---
layout: post
title: Android：外部SD卡路径的获取
description: 
categories: [android, dev]
tags: [android]
---

{% highlight java %}
/*
 * http://stackoverflow.com/a/18866046
 *
 * There are devices that have both an emulated and a physical SD. (eg Sony
 * Xperia Z). It won't expose the physical SD card because methods like
 * getExternalFilesDir(null) will return the emulated SD card. I use the
 * following code to get the directory for the physical SD. The call returns
 * all mountpoints and the online SD cards. You will have to figure out
 * which mountpoint refers to a OFFLINE SD card (if any), but most of the
 * time you are only interested in ONLINE SD cards.
 *
 * 在原来版本的基础上做了修改：
 * 1. vold.fstab中有效记录必须是"dev_mount"开头
 * dev_mount <label> <mount_point> <part> <sysfs_path1...>
 *
 * 2. moto的机器上fstab记录稍有不同
 * MOT XT882
 * dev_mount <label> <mount_point[:[asec_point]:[lun_point]]> <part> <sysfs_path1...>
 *
 * 3. sdCardsOnline 参数中将Environment.getExternalStorageDirectory() 放在list **第一个**。
 * 因为手机虚拟出来内存卡的话，就是Environment.getExternalStorageDirectory()
 * 但是有些手机（moto）能在/proc/mounts中扫清出虚拟内存卡的路径；有些手机（三星）不行。
 *
 */
public static boolean getMountPointsAndOnlineSDCardDirectories(
        ArrayList<String> mountPoints, ArrayList<String> sdCardsOnline) {
    boolean ok = true;

    if ( mountPoints != null ) {
        mountPoints.clear();

        try {
            // File that contains the filesystems to be mounted at system
            // startup
            // 4.3 以后 /etc/vold.fstab就没用了，放到/fstab.<device>，例如， fstab.qcom，这个文件要root才能看
            FileInputStream fs = new FileInputStream("/etc/vold.fstab");
            DataInputStream in = new DataInputStream(fs);
            BufferedReader br = new BufferedReader(new InputStreamReader(in));

            String line;
            while ((line = br.readLine()) != null) {
                // Skip comments and empty lines
                line = line.trim();
                if ((line.length() == 0) || (line.startsWith("#")))
                    continue;

                // Fields are separated by whitespace
                Log.d(TAG, "MOUNT POINT: " + line);
                String[] parts = line.split("\\s+");
                if (parts.length >= 3 && parts[0] != null && parts[0].equalsIgnoreCase("dev_mount")) {
                    // Add mountpoint
                    String mp = parts[2];
                    if( parts[2].contains(":") ) {
                        // moto phones, separate by colon, e.g.
                        // dev_mount sdcard_ext /mnt/sdcard-ext:none:lun1 auto /devices/platform/tegra-sdhci.2/mmc_host/mmc2 /devices/platform/tegra-sdhci.2/mmc_host/mmc1
                        String[] mount_parts = parts[2].split(":");
                        mp = mount_parts[0];
                    }
                    mountPoints.add(mp);
                    
                }
            }

            in.close();
        } catch (Exception e) {
            ok = false;
            e.printStackTrace();
        }
    }

    if( sdCardsOnline != null ) {
        sdCardsOnline.clear();
        try {

            // Pseudo file that holds the CURRENTLY mounted filesystems
            FileInputStream fs = new FileInputStream("/proc/mounts");
            DataInputStream in = new DataInputStream(fs);
            BufferedReader br = new BufferedReader(new InputStreamReader(in));

            String line;
            while ((line = br.readLine()) != null) {
                // A sdcard would typically contain these...
                String[] parts = line.split("\\s+");
                if( parts.length > 3 )
                {
                    for( String p : parts ) {
                        if( p==null ) {
                            continue;
                        }
                    }

                    String device = parts[0];
                    String mounton = parts[1]; // mount on
                    String mountPathName = new File(mounton).getName();
                    Log.d(TAG, "MOUNT PATH NAME:" + mountPathName);
                    String fsformat = parts[2]; // filesystem format, sdcard normally is vfat
                    // fs param, e.g.
                    // rw,dirsync,nosuid,nodev,noexec,noatime,nodiratime,uid=1000,gid=1023,fmask=0002,dmask=0002,allow_utime=0020,codepage=cp437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro
                    String fsparam = parts[3].toLowerCase();
                    
                    if( !device.startsWith("/dev/block") ) {
                        continue;
                    }
                    
                    if( mounton.equals(Environment.getExternalStorageDirectory().getAbsolutePath()) ) {
                        continue;
                    }
                    
                    // ignore secure partition
                    if( mountPathName.equals("asec") || mountPathName.equals("secure") ) {
                        Log.d(TAG, "security partition ignored!");
                        continue;
                    }
                    
                    if( !fsformat.equals("vfat") ){
                        continue;
                    }
                    
                    if( !fsparam.startsWith("rw") || !fsparam.contains("dirsync") ) {
                        continue;
                    }
                    

                    sdCardsOnline.add(mounton);
                }
            }

            // Close the stream
            in.close();
        } catch (Exception e) {
            e.printStackTrace();
            ok = false;
        }
        
        sdCardsOnline.add(0, Environment.getExternalStorageDirectory().getAbsolutePath());
    }

    return (ok);
}//END OF FUNCTION getMountPointsAndOnlineSDCardDirectories


public File findFileInSdcard(String path) {
    File ret = null;
    
    // 按顺序检查多个SDCard根目录，内部虚拟存储卡优先于外部存储卡。
    // 由于现在还没出现可以挂载多个外部存储卡的手机，所以不考虑外部存储卡的优先级。
    ret = new File(Environment.getExternalStorageDirectory(), path);
    ArrayList<String> sdCardsOnline = new ArrayList<String>();
    getMountPointsAndOnlineSDCardDirectories(null, sdCardsOnline);
    for ( String sd : sdCardsOnline ) {
        ret = new File(sd, path);
        if( ret.exists() ) {
            break;
        }
    }
    return ret;
}
{% endhighlight %}