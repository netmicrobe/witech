---
layout: post
title: 在 Linux 系统中查看 SSD 的 SMART 信息
categories: [cm, linux]
tags: [ssd, smartmontools, smartctl]
---

* 参考： 
  * [How to check SSD health in Linux](https://www.techrepublic.com/article/how-to-check-ssd-health-in-linux/)
  * [List of S.M.A.R.T. attributes](http://www.cropel.com/library/smart-attribute-list.aspx)
  * []()


## 查看机器内置硬盘信息

~~~
sudo smartctl -i /dev/sdX
~~~

或者，用 `-a` 参数查看所有信息 `sudo smartctl -a /dev/sdX`

## 查看移动固态硬盘（pssd）信息

~~~
sudo smartctl -d sat -i /dev/sdb
~~~

### 三星固态硬盘的健康状态信息


#### 已写数据量

* ref
  * [Samsung SSDs: Reading Total Bytes Written Under Linux](http://www.jdgleaver.co.uk/blog/2014/05/23/samsung_ssds_reading_total_bytes_written_under_linux.html)
  * [How can I monitor the TBW on my Samsung SSD?
](https://askubuntu.com/questions/865792/how-can-i-monitor-the-tbw-on-my-samsung-ssd)

~~~
echo "GB Written: $(echo "scale=3; $(sudo /usr/sbin/smartctl -d sat -A /dev/sdb | grep "Total_LBAs_Written" | awk '{print $10}') * 512 / 1073741824" | bc | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta')"
~~~


### P/E Cycles / ID # 177 Wear Leveling Count

* ref:
  * <https://unix.stackexchange.com/a/191484/346654>

For Samsung SSDs, check SMART attribute 177 (Wear Leveling Count).

~~~
ID # 177 Wear Leveling Count

This attribute represents the number of media program and erase operations (the number of times a block has been erased). This value is directly related to the lifetime of the SSD. The raw value of this attribute shows the total count of P/E Cycles.
~~~

#### samsung_ssd_get_lifetime_writes.bash

* 用之前改下 "SSD_DEVICE" 变量


~~~#!/bin/bash

#######################################
# Variables                           #
#######################################

SSD_DEVICE="/dev/sdb"

ON_TIME_TAG="Power_On_Hours"
WEAR_COUNT_TAG="Wear_Leveling_Count"
LBAS_WRITTEN_TAG="Total_LBAs_Written"
LBA_SIZE=512 # Value in bytes

BYTES_PER_MB=1048576
BYTES_PER_GB=1073741824
BYTES_PER_TB=1099511627776

#######################################
# Get total data written...           #
#######################################

# Get SMART attributes
SMART_INFO=$(sudo /usr/sbin/smartctl -d sat -A "$SSD_DEVICE")

# Extract required attributes
ON_TIME=$(echo "$SMART_INFO" | grep "$ON_TIME_TAG" | awk '{print $10}')
WEAR_COUNT=$(echo "$SMART_INFO" | grep "$WEAR_COUNT_TAG" | awk '{print $4}' | sed 's/^0*//')
LBAS_WRITTEN=$(echo "$SMART_INFO" | grep "$LBAS_WRITTEN_TAG" | awk '{print $10}')

# Convert LBAs -> bytes
BYTES_WRITTEN=$(echo "$LBAS_WRITTEN * $LBA_SIZE" | bc)
MB_WRITTEN=$(echo "scale=3; $BYTES_WRITTEN / $BYTES_PER_MB" | bc)
GB_WRITTEN=$(echo "scale=3; $BYTES_WRITTEN / $BYTES_PER_GB" | bc)
TB_WRITTEN=$(echo "scale=3; $BYTES_WRITTEN / $BYTES_PER_TB" | bc)

# Output results...
echo "------------------------------"
echo " SSD Status:   $SSD_DEVICE"
echo "------------------------------"
echo " On time:      $(echo $ON_TIME | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta') hr"
echo "------------------------------"
echo " Data written:"
echo "           MB: $(echo $MB_WRITTEN | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta')"
echo "           GB: $(echo $GB_WRITTEN | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta')"
echo "           TB: $(echo $TB_WRITTEN | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta')"
echo "------------------------------"
echo " Mean write rate:"
echo "        MB/hr: $(echo "scale=3; $MB_WRITTEN / $ON_TIME" | bc | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta')"
echo "------------------------------"
echo " Drive health: ${WEAR_COUNT} %"
echo "------------------------------"
~~~


执行效果

~~~
$ ./samsung_ssd_get_lifetime_writes.bash 
------------------------------
 SSD Status:   /dev/sdb
------------------------------
 On time:      3 hr
------------------------------
 Data written:
           MB: 14,081.572
           GB: 13.751
           TB: .013
------------------------------
 Mean write rate:
        MB/hr: 4,693.857
------------------------------
 Drive health: 100 %
------------------------------
~~~






