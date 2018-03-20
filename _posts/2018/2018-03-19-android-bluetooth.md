---
layout: post
title: Android 上使用 蓝牙（Bluetooth）
categories: [ dev, android ]
tags: [ bluetooth ]
---


* 参考
  * <https://developer.android.com/guide/topics/connectivity/bluetooth.html>

[BluetoothAdapter]: https://developer.android.com/reference/android/bluetooth/BluetoothAdapter.html


## Setting Up Bluetooth

1. Get the [BluetoothAdapter].
    ~~~ java
    BluetoothAdapter mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
    if (mBluetoothAdapter == null) {
        // Device doesn't support Bluetooth
    }
    ~~~
2. Enable Bluetooth.
    ~~~ java
    if (!mBluetoothAdapter.isEnabled()) {
        Intent enableBtIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
        // The REQUEST_ENABLE_BT constant passed to startActivityForResult() is a locally defined integer that must be greater than 0.
        startActivityForResult(enableBtIntent, REQUEST_ENABLE_BT);
    }
    ~~~
    
    A dialog appears requesting user permission to enable Bluetooth, as shown in Figure 1. If the user responds "Yes", the system begins to enable Bluetooth, and focus returns to your application once the process completes (or fails).
    
    [](bt_enable_request.png)
    
    If enabling Bluetooth succeeds, your activity receives the RESULT_OK result code in the onActivityResult() callback. If Bluetooth was not enabled due to an error (or the user responded "No") then the result code is RESULT_CANCELED.


## Bluetooth 状态改变

Optionally, your application can also listen for the ACTION_STATE_CHANGED broadcast intent, which the system broadcasts whenever the Bluetooth state changes. 

 This broadcast contains the extra fields EXTRA_STATE and EXTRA_PREVIOUS_STATE, containing the new and old Bluetooth states, respectively. Possible values for these extra fields are STATE_TURNING_ON, STATE_ON, STATE_TURNING_OFF, and STATE_OFF. Listening for this broadcast can be useful if your app needs to detect runtime changes made to the Bluetooth state.



## Finding Devices

* through device discovery
  * Device discovery is a scanning procedure that searches the local area for Bluetooth-enabled devices and requests some information about each one. 
  * This process is sometimes referred to as *discovering, inquiring, or scanning*.
  * If a device is discoverable, it responds to the discovery request by sharing some information, such as the device's name, its class, and its unique MAC address.
* by querying the list of paired devices
  * Once a connection is made with a remote device for the first time, a pairing request is automatically presented to the user. 
  * When a device is paired, the basic information about that device—such as the device's name, class, and MAC address—is saved and can be read using the Bluetooth APIs.



### Querying paired devices

~~~ java
Set<BluetoothDevice> pairedDevices = mBluetoothAdapter.getBondedDevices();

if (pairedDevices.size() > 0) {
    // There are paired devices. Get the name and address of each paired device.
    for (BluetoothDevice device : pairedDevices) {
        String deviceName = device.getName();
        String deviceHardwareAddress = device.getAddress(); // MAC address
    }
}
~~~








































































