---
layout: post
title: adb dumpsys
description: 
categories: [cm, android]
tags: [android, dumpsys, adb]
---

省略包名就打印出系统所有task，一般不怎么做。

  adb shell dumpsys activity 包名

打印出Activity Manager的内容，其中Hist就是back task。

  adb shell dumpsys activity activities


## dumpsys 可dump出哪些系统信息
 
Get the list of services available

~~~
adb shell service list
~~~

## dumpsys package 打印出包信息

~~~ shell
# 打印出所有包信息
adb shell dumpsys package
~~~

~~~ shell
# 打印出指定包信息
adb shell dumpsys package <package-name>
~~~

例如:

~~~
$ adb shell dumpsys package com.huawei.securitymgr
Receiver Resolver Table:
  Schemes:
      package:
        71fab0 com.huawei.securitymgr/.AppUninstallReceiver

Service Resolver Table:
  Non-Data Actions:
      com.huawei.securitymgr.AuthenticationService:
        5f79ec6 com.huawei.securitymgr/.AuthenticationService

Permissions:
  Permission [com.huawei.authentication.HW_ACCESS_AUTH_SERVICE] (85966f):
    sourcePackage=com.huawei.securitymgr
    uid=1000 gids=null type=0 prot=normal
    perm=Permission{5910f7c com.huawei.authentication.HW_ACCESS_AUTH_SERVICE}
    packageSetting=PackageSetting{de9cb72 com.huawei.securitymgr/1000}

Registered ContentProviders:
  com.huawei.securitymgr/.contentprovider.AlipayContentProvider:
    Provider{9f4db2d com.huawei.securitymgr/.contentprovider.AlipayContentProvider}

ContentProvider Authorities:
  [authentication.information]:
    Provider{9f4db2d com.huawei.securitymgr/.contentprovider.AlipayContentProvider}
      applicationInfo=ApplicationInfo{d6d3245 com.huawei.securitymgr}

Key Set Manager:
  [com.huawei.securitymgr]
      Signing KeySets: 1

Packages:
  Package [com.huawei.securitymgr] (de9cb72):
    userId=1000
    sharedUser=SharedUserSetting{5625f1c android.uid.system/1000}
    pkg=Package{dfc74bf com.huawei.securitymgr}
    codePath=/system/app/HwSecurityMgrService
    resourcePath=/system/app/HwSecurityMgrService
    legacyNativeLibraryDir=/system/app/HwSecurityMgrService/lib
    primaryCpuAbi=arm64-v8a
    secondaryCpuAbi=null
    versionCode=81101 targetSdk=23
    versionName=8.1.101
    splits=[base]
    applicationInfo=ApplicationInfo{d6d3245 com.huawei.securitymgr}
    flags=[ SYSTEM HAS_CODE PERSISTENT ALLOW_CLEAR_USER_DATA ]
    dataDir=/data/user/0/com.huawei.securitymgr
    supportsScreens=[small, medium, large, xlarge, resizeable, anyDensity]
    timeStamp=2017-09-28 22:50:30
    firstInstallTime=2017-03-25 21:13:06
    lastUpdateTime=2017-09-28 22:50:30
    signatures=PackageSignatures{9f68e9 [dbf83ee]}
    installPermissionsFixed=true installStatus=1
    pkgFlags=[ SYSTEM HAS_CODE PERSISTENT ALLOW_CLEAR_USER_DATA ]
    declared permissions:
      com.huawei.authentication.HW_ACCESS_AUTH_SERVICE: prot=normal, INSTALLED
    requested permissions:
      android.permission.USE_FINGERPRINT
      android.permission.MANAGE_FINGERPRINT
      com.huawei.authentication.HW_ACCESS_AUTH_SERVICE
    install permissions:
      android.permission.REAL_GET_TASKS: granted=true
      android.permission.BIND_INCALL_SERVICE: granted=true
      android.permission.WRITE_SETTINGS: granted=true
      com.huawei.hwresolver.resolverReceiver: granted=true
      com.huawei.intelligent.permission.READ_INTELLIGENT_PROVIDER: granted=true
      android.permission.CONFIGURE_WIFI_DISPLAY: granted=true
      android.permission.ACCESS_WIMAX_STATE: granted=true
      com.huawei.android.permission.INJECT_LOCATION: granted=true
      android.permission.USES_HW_LOG_SERVICE: granted=true
      android.permission.USE_CREDENTIALS: granted=true
      android.permission.MODIFY_AUDIO_SETTINGS: granted=true
      android.permission.ACCESS_CHECKIN_PROPERTIES: granted=true
      com.huawei.motion.permission.ACCESS_MOTION: granted=true
      com.huawei.android.permission.RECEIVE_REPAIR_HELPER_DATA: granted=true
      android.permission.GET_APP_OPS_STATS: granted=true
      com.huawei.gallery.permission.SHARE_CALLBACK: granted=true
      com.huawei.motion.permission.MOTION_ACTION_OPERATE: granted=true
      android.permission.INSTALL_LOCATION_PROVIDER: granted=true
      android.permission.SYSTEM_ALERT_WINDOW: granted=true
      android.permission.BROADCAST_PHONE_ACCOUNT_REGISTRATION: granted=true
      org.simalliance.openmobileapi.service.permission.CHECK_X509: granted=true
      android.permission.CONTROL_LOCATION_UPDATES: granted=true
      com.huawei.motion.permission.WRITE_DATA: granted=true
      android.permission.CLEAR_APP_USER_DATA: granted=true
      android.permission.BROADCAST_CALLLOG_INFO: granted=true
      android.permission.NFC: granted=true
      android.permission.RECEIVE_SMS_INTERCEPTION: granted=true
      android.permission.START_ANY_ACTIVITY: granted=true
      huawei.permission.RECEIVE_CLOUD_OTA_UPDATA: granted=true
      android.permission.CALL_PRIVILEGED: granted=true
      android.permission.CHANGE_NETWORK_STATE: granted=true
      android.permission.MASTER_CLEAR: granted=true
      android.permission.WRITE_SYNC_SETTINGS: granted=true
      com.huawei.vassistant.settings.permission.VASSISTANT_SETTINGS: granted=true
      com.huawei.android.permission.SEND_REPAIR_HELPER_DATA: granted=true
      com.android.systemui.permission.removeTask: granted=true
      android.permission.RECEIVE_BOOT_COMPLETED: granted=true
      com.google.android.googleapps.permission.GOOGLE_AUTH: granted=true
      android.permission.EASY_WAKE_UP: granted=true
      com.android.contacts.permission.READ_CONTACTS_PRIVACY_DATA: granted=true
      android.permission.PEERS_MAC_ADDRESS: granted=true
      android.permission.DEVICE_POWER: granted=true
      android.permission.IBINDER_APP_WIDGET_SERVICE: granted=true
      com.android.launcher.permission.UNINSTALL_SHORTCUT: granted=true
      android.permission.MANAGE_PROFILE_AND_DEVICE_OWNERS: granted=true
      android.permission.READ_PROFILE: granted=true
      com.huawei.permission.WIFIPRO_BQE_SERVER_RECEIVE: granted=true
      android.permission.BLUETOOTH: granted=true
      android.permission.CHANGE_WIFI_MULTICAST_STATE: granted=true
      android.permission.USES_LOG_UPLOAD_SERVICE: granted=true
      android.permission.WRITE_MEDIA_STORAGE: granted=true
      com.qualcomm.permission.USE_QCRIL_MSG_TUNNEL: granted=true
      android.permission.GET_TASKS: granted=true
      android.permission.INTERNET: granted=true
      huawei.android.permission.RESET_NEW_PASSWORD: granted=true
      android.permission.BLUETOOTH_ADMIN: granted=true
      android.permission.CONTROL_VPN: granted=true
      android.permission.READ_PRECISE_PHONE_STATE: granted=true
      android.permission.MANAGE_FINGERPRINT: granted=true
      com.qualcomm.permission.IZAT: granted=true
      huawei.android.permission.RESTORE_DEFAULT_SETTINGS: granted=true
      com.huawei.phoneservice.permission.SMART_FAQS_ACCESS: granted=true
      android.permission.BIND_CONNECTION_SERVICE: granted=true
      com.android.phone.permission.AUTOIP_STATUS_CHANGED: granted=true
      com.huawei.parentcontrol.permission.provider: granted=true
      android.permission.GET_PACKAGE_SIZE: granted=true
      com.huawei.android.launcher.permission.CHANGE_POWERMODE: granted=true
      android.permission.MANAGE_USB: granted=true
      android.permission.INTERACT_ACROSS_USERS_FULL: granted=true
      android.permission.STOP_APP_SWITCHES: granted=true
      android.permission.BATTERY_STATS: granted=true
      android.permission.PACKAGE_USAGE_STATS: granted=true
      android.permission.MOUNT_UNMOUNT_FILESYSTEMS: granted=true
      android.permission.WRITE_SECURE_SETTINGS: granted=true
      huawei.android.permission.HW_SIGNATURE_OR_SYSTEM: granted=true
      android.permission.HUAWEI_IME_STATE_ACCESS: granted=true
      android.permission.MOVE_PACKAGE: granted=true
      android.permission.SET_ACTIVITY_WATCHER: granted=true
      android.permission.READ_SEARCH_INDEXABLES: granted=true
      com.android.providers.media.permission.SCAN_FOLDER: granted=true
      android.permission.ACCESS_DOWNLOAD_MANAGER: granted=true
      android.permission.BLUETOOTH_PRIVILEGED: granted=true
      android.permission.IBINDER_NOTIFICATION_SERVICE: granted=true
      android.permission.HARDWARE_TEST: granted=true
      android.permission.WRITE_SMS: granted=true
      android.intent.category.MASTER_CLEAR.permission.C2D_MESSAGE: granted=true
      android.permission.BIND_JOB_SERVICE: granted=true
      android.permission.CONFIRM_FULL_BACKUP: granted=true
      android.permission.SET_TIME: granted=true
      android.permission.WRITE_APN_SETTINGS: granted=true
      android.permission.CHANGE_WIFI_STATE: granted=true
      android.permission.MANAGE_USERS: granted=true
      android.permission.SET_PREFERRED_APPLICATIONS: granted=true
      android.permission.FLASHLIGHT: granted=true
      android.permission.DELETE_CACHE_FILES: granted=true
      android.permission.ACCESS_NETWORK_STATE: granted=true
      android.permission.DISABLE_KEYGUARD: granted=true
      android.permission.BACKUP: granted=true
      android.permission.CHANGE_CONFIGURATION: granted=true
      android.permission.USER_ACTIVITY: granted=true
      android.permission.READ_LOGS: granted=true
      android.permission.COPY_PROTECTED_DATA: granted=true
      android.permission.INTERACT_ACROSS_USERS: granted=true
      com.android.huawei.permission.HWINTERNETAUDIO_ACCESS_AIDL: granted=true
      com.huawei.motion.permission.READ_DATA: granted=true
      android.permission.SET_KEYBOARD_LAYOUT: granted=true
      com.huawei.powergenie.receiverPermission: granted=true
      com.android.contacts.permission.READ_CONTACTS_PRIVATE_INFO: granted=true
      com.huawei.android.launcher.permission.READ_SETTINGS: granted=true
      android.permission.READ_NETWORK_USAGE_HISTORY: granted=true
      android.permission.KILL_BACKGROUND_PROCESSES: granted=true
      android.permission.USE_FINGERPRINT: granted=true
      android.permission.WRITE_USER_DICTIONARY: granted=true
      android.permission.READ_SYNC_STATS: granted=true
      com.android.bluetooth.permission.BLUETOOTH_FREEZE_POWER_GENIE: granted=true
      broadcast.cne.permission: granted=true
      android.permission.REBOOT: granted=true
      com.huawei.camera.permission.PRIVATE: granted=true
      com.huawei.android.permission.SET_CHR_DATA: granted=true
      android.permission.OEM_UNLOCK_STATE: granted=true
      android.permission.MANAGE_DEVICE_ADMINS: granted=true
      android.permission.CLEAR_APP_CACHE: granted=true
      com.huawei.remotocontrol.permission.REMOTECALL: granted=true
      com.huawei.authentication.HW_ACCESS_AUTH_SERVICE: granted=true
      android.permission.STK_CHECK_SCREEN_IDLE: granted=true
      android.permission.CHANGE_APP_IDLE_STATE: granted=true
      com.huawei.hidisk.FingerPrintProvider.permission.ACCESS: granted=true
      com.huawei.motion.permission.START_MOTION_SERVICE: granted=true
      wt.protect.camerastability: granted=true
      android.permission.SET_POINTER_SPEED: granted=true
      com.android.huawei.permission.REPORT_FM_STATUS: granted=true
      android.permission.CONNECTIVITY_INTERNAL: granted=true
      android.permission.READ_SYNC_SETTINGS: granted=true
      com.huawei.contacts.permission.HW_CONTACTS_ALL: granted=true
      android.permission.OVERRIDE_WIFI_CONFIG: granted=true
      android.permission.FORCE_STOP_PACKAGES: granted=true
      android.permission.HIDE_NON_SYSTEM_OVERLAY_WINDOWS: granted=true
      android.permission.ACCESS_NOTIFICATIONS: granted=true
      com.huawei.vdrive.providers.settings.permission.READ_ONLY: granted=true
      android.permission.VIBRATE: granted=true
      com.android.certinstaller.INSTALL_AS_USER: granted=true
      com.huawei.rcs.READ_MESSAGE: granted=true
      android.permission.READ_USER_DICTIONARY: granted=true
      com.huawei.systemmanager.permission.ACCESS_INTERFACE: granted=true
      android.permission.ACCESS_WIFI_STATE: granted=true
      com.huawei.permission.WIFIPRO_BQE_SERVICE: granted=true
      android.permission.CHANGE_WIMAX_STATE: granted=true
      android.permission.MODIFY_PHONE_STATE: granted=true
      android.permission.PACKET_KEEPALIVE_OFFLOAD: granted=true
      com.android.launcher.permission.INSTALL_SHORTCUT: granted=true
      android.permission.STATUS_BAR: granted=true
      android.permission.HSM_SMCS: granted=true
      android.permission.LOCATION_HARDWARE: granted=true
      android.permission.WAKE_LOCK: granted=true
      android.permission.INJECT_EVENTS: granted=true
      com.huawei.android.launcher.permission.ONEKEYCLEAN: granted=true
      android.permission.USES_HW_RIL_TUNNEL: granted=true
      com.huawei.vassistant.providers.settings.permission.READ_ONLY: granted=true
      com.huawei.motion.permission.MOTION_ACTION_RECOGNITION: granted=true
      android.permission.UPDATE_APP_OPS_STATS: granted=true
      com.huawei.locksettings.permission.ACCESS_HWKEYGUARD_SECURE_STORAGE: granted=true
      android.permission.DELETE_PACKAGES: granted=true
    User 0:  installed=true hidden=false stopped=false notLaunched=false enabled=0

Shared users:
  SharedUser [android.uid.system] (5625f1c):
    userId=1000
    install permissions:
      android.permission.REAL_GET_TASKS: granted=true
      android.permission.BIND_INCALL_SERVICE: granted=true
      android.permission.WRITE_SETTINGS: granted=true
      com.huawei.hwresolver.resolverReceiver: granted=true
      com.huawei.intelligent.permission.READ_INTELLIGENT_PROVIDER: granted=true
      android.permission.CONFIGURE_WIFI_DISPLAY: granted=true
      android.permission.ACCESS_WIMAX_STATE: granted=true
      com.huawei.android.permission.INJECT_LOCATION: granted=true
      android.permission.USES_HW_LOG_SERVICE: granted=true
      android.permission.USE_CREDENTIALS: granted=true
      android.permission.MODIFY_AUDIO_SETTINGS: granted=true
      android.permission.ACCESS_CHECKIN_PROPERTIES: granted=true
      com.huawei.motion.permission.ACCESS_MOTION: granted=true
      com.huawei.android.permission.RECEIVE_REPAIR_HELPER_DATA: granted=true
      android.permission.GET_APP_OPS_STATS: granted=true
      com.huawei.gallery.permission.SHARE_CALLBACK: granted=true
      com.huawei.motion.permission.MOTION_ACTION_OPERATE: granted=true
      android.permission.INSTALL_LOCATION_PROVIDER: granted=true
      android.permission.SYSTEM_ALERT_WINDOW: granted=true
      android.permission.BROADCAST_PHONE_ACCOUNT_REGISTRATION: granted=true
      org.simalliance.openmobileapi.service.permission.CHECK_X509: granted=true
      android.permission.CONTROL_LOCATION_UPDATES: granted=true
      com.huawei.motion.permission.WRITE_DATA: granted=true
      android.permission.CLEAR_APP_USER_DATA: granted=true
      android.permission.BROADCAST_CALLLOG_INFO: granted=true
      android.permission.NFC: granted=true
      android.permission.RECEIVE_SMS_INTERCEPTION: granted=true
      android.permission.START_ANY_ACTIVITY: granted=true
      huawei.permission.RECEIVE_CLOUD_OTA_UPDATA: granted=true
      android.permission.CALL_PRIVILEGED: granted=true
      android.permission.CHANGE_NETWORK_STATE: granted=true
      android.permission.MASTER_CLEAR: granted=true
      android.permission.WRITE_SYNC_SETTINGS: granted=true
      com.huawei.vassistant.settings.permission.VASSISTANT_SETTINGS: granted=true
      com.huawei.android.permission.SEND_REPAIR_HELPER_DATA: granted=true
      com.android.systemui.permission.removeTask: granted=true
      android.permission.RECEIVE_BOOT_COMPLETED: granted=true
      com.google.android.googleapps.permission.GOOGLE_AUTH: granted=true
      android.permission.EASY_WAKE_UP: granted=true
      com.android.contacts.permission.READ_CONTACTS_PRIVACY_DATA: granted=true
      android.permission.PEERS_MAC_ADDRESS: granted=true
      android.permission.DEVICE_POWER: granted=true
      android.permission.IBINDER_APP_WIDGET_SERVICE: granted=true
      com.android.launcher.permission.UNINSTALL_SHORTCUT: granted=true
      android.permission.MANAGE_PROFILE_AND_DEVICE_OWNERS: granted=true
      android.permission.READ_PROFILE: granted=true
      com.huawei.permission.WIFIPRO_BQE_SERVER_RECEIVE: granted=true
      android.permission.BLUETOOTH: granted=true
      android.permission.CHANGE_WIFI_MULTICAST_STATE: granted=true
      android.permission.USES_LOG_UPLOAD_SERVICE: granted=true
      android.permission.WRITE_MEDIA_STORAGE: granted=true
      com.qualcomm.permission.USE_QCRIL_MSG_TUNNEL: granted=true
      android.permission.GET_TASKS: granted=true
      android.permission.INTERNET: granted=true
      huawei.android.permission.RESET_NEW_PASSWORD: granted=true
      android.permission.BLUETOOTH_ADMIN: granted=true
      android.permission.CONTROL_VPN: granted=true
      android.permission.READ_PRECISE_PHONE_STATE: granted=true
      android.permission.MANAGE_FINGERPRINT: granted=true
      com.qualcomm.permission.IZAT: granted=true
      huawei.android.permission.RESTORE_DEFAULT_SETTINGS: granted=true
      com.huawei.phoneservice.permission.SMART_FAQS_ACCESS: granted=true
      android.permission.BIND_CONNECTION_SERVICE: granted=true
      com.android.phone.permission.AUTOIP_STATUS_CHANGED: granted=true
      com.huawei.parentcontrol.permission.provider: granted=true
      android.permission.GET_PACKAGE_SIZE: granted=true
      com.huawei.android.launcher.permission.CHANGE_POWERMODE: granted=true
      android.permission.MANAGE_USB: granted=true
      android.permission.INTERACT_ACROSS_USERS_FULL: granted=true
      android.permission.STOP_APP_SWITCHES: granted=true
      android.permission.BATTERY_STATS: granted=true
      android.permission.PACKAGE_USAGE_STATS: granted=true
      android.permission.MOUNT_UNMOUNT_FILESYSTEMS: granted=true
      android.permission.WRITE_SECURE_SETTINGS: granted=true
      huawei.android.permission.HW_SIGNATURE_OR_SYSTEM: granted=true
      android.permission.HUAWEI_IME_STATE_ACCESS: granted=true
      android.permission.MOVE_PACKAGE: granted=true
      android.permission.SET_ACTIVITY_WATCHER: granted=true
      android.permission.READ_SEARCH_INDEXABLES: granted=true
      com.android.providers.media.permission.SCAN_FOLDER: granted=true
      android.permission.ACCESS_DOWNLOAD_MANAGER: granted=true
      android.permission.BLUETOOTH_PRIVILEGED: granted=true
      android.permission.IBINDER_NOTIFICATION_SERVICE: granted=true
      android.permission.HARDWARE_TEST: granted=true
      android.permission.WRITE_SMS: granted=true
      android.intent.category.MASTER_CLEAR.permission.C2D_MESSAGE: granted=true
      android.permission.BIND_JOB_SERVICE: granted=true
      android.permission.CONFIRM_FULL_BACKUP: granted=true
      android.permission.SET_TIME: granted=true
      android.permission.WRITE_APN_SETTINGS: granted=true
      android.permission.CHANGE_WIFI_STATE: granted=true
      android.permission.MANAGE_USERS: granted=true
      android.permission.SET_PREFERRED_APPLICATIONS: granted=true
      android.permission.FLASHLIGHT: granted=true
      android.permission.DELETE_CACHE_FILES: granted=true
      android.permission.ACCESS_NETWORK_STATE: granted=true
      android.permission.DISABLE_KEYGUARD: granted=true
      android.permission.BACKUP: granted=true
      android.permission.CHANGE_CONFIGURATION: granted=true
      android.permission.USER_ACTIVITY: granted=true
      android.permission.READ_LOGS: granted=true
      android.permission.COPY_PROTECTED_DATA: granted=true
      android.permission.INTERACT_ACROSS_USERS: granted=true
      com.android.huawei.permission.HWINTERNETAUDIO_ACCESS_AIDL: granted=true
      com.huawei.motion.permission.READ_DATA: granted=true
      android.permission.SET_KEYBOARD_LAYOUT: granted=true
      com.huawei.powergenie.receiverPermission: granted=true
      com.android.contacts.permission.READ_CONTACTS_PRIVATE_INFO: granted=true
      com.huawei.android.launcher.permission.READ_SETTINGS: granted=true
      android.permission.READ_NETWORK_USAGE_HISTORY: granted=true
      android.permission.KILL_BACKGROUND_PROCESSES: granted=true
      android.permission.USE_FINGERPRINT: granted=true
      android.permission.WRITE_USER_DICTIONARY: granted=true
      android.permission.READ_SYNC_STATS: granted=true
      com.android.bluetooth.permission.BLUETOOTH_FREEZE_POWER_GENIE: granted=true
      broadcast.cne.permission: granted=true
      android.permission.REBOOT: granted=true
      com.huawei.camera.permission.PRIVATE: granted=true
      com.huawei.android.permission.SET_CHR_DATA: granted=true
      android.permission.OEM_UNLOCK_STATE: granted=true
      android.permission.MANAGE_DEVICE_ADMINS: granted=true
      android.permission.CLEAR_APP_CACHE: granted=true
      com.huawei.remotocontrol.permission.REMOTECALL: granted=true
      com.huawei.authentication.HW_ACCESS_AUTH_SERVICE: granted=true
      android.permission.STK_CHECK_SCREEN_IDLE: granted=true
      android.permission.CHANGE_APP_IDLE_STATE: granted=true
      com.huawei.hidisk.FingerPrintProvider.permission.ACCESS: granted=true
      com.huawei.motion.permission.START_MOTION_SERVICE: granted=true
      wt.protect.camerastability: granted=true
      android.permission.SET_POINTER_SPEED: granted=true
      com.android.huawei.permission.REPORT_FM_STATUS: granted=true
      android.permission.CONNECTIVITY_INTERNAL: granted=true
      android.permission.READ_SYNC_SETTINGS: granted=true
      com.huawei.contacts.permission.HW_CONTACTS_ALL: granted=true
      android.permission.OVERRIDE_WIFI_CONFIG: granted=true
      android.permission.FORCE_STOP_PACKAGES: granted=true
      android.permission.HIDE_NON_SYSTEM_OVERLAY_WINDOWS: granted=true
      android.permission.ACCESS_NOTIFICATIONS: granted=true
      com.huawei.vdrive.providers.settings.permission.READ_ONLY: granted=true
      android.permission.VIBRATE: granted=true
      com.android.certinstaller.INSTALL_AS_USER: granted=true
      com.huawei.rcs.READ_MESSAGE: granted=true
      android.permission.READ_USER_DICTIONARY: granted=true
      com.huawei.systemmanager.permission.ACCESS_INTERFACE: granted=true
      android.permission.ACCESS_WIFI_STATE: granted=true
      com.huawei.permission.WIFIPRO_BQE_SERVICE: granted=true
      android.permission.CHANGE_WIMAX_STATE: granted=true
      android.permission.MODIFY_PHONE_STATE: granted=true
      android.permission.PACKET_KEEPALIVE_OFFLOAD: granted=true
      com.android.launcher.permission.INSTALL_SHORTCUT: granted=true
      android.permission.STATUS_BAR: granted=true
      android.permission.HSM_SMCS: granted=true
      android.permission.LOCATION_HARDWARE: granted=true
      android.permission.WAKE_LOCK: granted=true
      android.permission.INJECT_EVENTS: granted=true
      com.huawei.android.launcher.permission.ONEKEYCLEAN: granted=true
      android.permission.USES_HW_RIL_TUNNEL: granted=true
      com.huawei.vassistant.providers.settings.permission.READ_ONLY: granted=true
      com.huawei.motion.permission.MOTION_ACTION_RECOGNITION: granted=true
      android.permission.UPDATE_APP_OPS_STATS: granted=true
      com.huawei.locksettings.permission.ACCESS_HWKEYGUARD_SECURE_STORAGE: granted=true
      android.permission.DELETE_PACKAGES: granted=true
    User 0:
      gids=[3002, 1023, 1015, 3003, 3001, 1021, 3004, 3005, 1000, 2002, 3009, 1010, 1007, 3006]
      runtime permissions:
        android.permission.READ_SMS: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.READ_CALL_LOG: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.ACCESS_FINE_LOCATION: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.RECEIVE_WAP_PUSH: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.RECEIVE_SMS: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.READ_EXTERNAL_STORAGE: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.ACCESS_COARSE_LOCATION: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.READ_PHONE_STATE: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.SEND_SMS: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.CALL_PHONE: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.WRITE_CONTACTS: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.CAMERA: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.WRITE_CALL_LOG: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.PROCESS_OUTGOING_CALLS: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.WRITE_EXTERNAL_STORAGE: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        com.huawei.contacts.permission.CHOOSE_SUBSCRIPTION: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.RECORD_AUDIO: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
        android.permission.READ_CONTACTS: granted=true, flags=[ SYSTEM_FIXED GRANTED_BY_DEFAULT ]
~~~





