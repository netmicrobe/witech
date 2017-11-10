---
layout: post
title: php 修改 ldap 用户密码
categories: [dev, php]
tags: [ldap, php]
---

* 参考：
  * <https://wenzhang.baidu.com/article/view?key=2381c0892e171dcb-1464658206>



### ldap_pass_change.phps


~~~ php
<?php
$server = "localhost";
$dn = "dc=tejasbarot,dc=com";
$message = array();

function changePassword($server,$dn,$user,$oldPassword,$newPassword,$newPasswordCnf){
  global $message;

  error_reporting(0);

  $con=ldap_connect($server);
  ldap_set_option($con, LDAP_OPT_PROTOCOL_VERSION, 3);

  $findWhat = array ("cn","mail");
  $findWhere = $dn;
  $findFilter = "(uid=$user)";

  #bind anon and find user by uid
  $sr = ldap_search($con,$dn,$findFilter,$findWhat);
  $records = ldap_get_entries($con, $sr);
  // echo "<pre>";print_r($records);
  /* error if found more than one user */
  if ($records["count"] != "1") {
    $message[] = "Error E100 - Wrong user.";
    return false;
  }else {
    $message[] = "Found user <b>".$records[0]["cn"][0]."</b>";
  }

  /* try to bind as that user */
  if (ldap_bind($con, $records[0]["dn"], $oldPassword) === false) {
    $message[] = "Error E104 - Current password is wrong.";
    return false;
  }
  else { }

  if ($newPassword != $newPasswordCnf ) {
    $message[] = "Error E101 - New passwords do not match! ";
    return false;
  }
  if (strlen($newPassword) < 8 ) {
    $message[] = "Error E102 - Your new password is too short! ";
    return false;
  }
  if (!preg_match("/[0-9]/",$newPassword)) {
    $message[] = "Error E103 - Your password must contain at least one digit. ";
    return false;
  }
  if (!preg_match("/[a-zA-Z]/",$newPassword)) {
    $message[] = "Error E103 - Your password must contain at least one letter. ";
    return false;
  }


  /* change the password finally */
  $entry = array();
  $entry["userPassword"] = "{SHA}" . base64_encode( pack( "H*", sha1( $newPassword ) ) );
  if (ldap_modify($con,$records[0]["dn"],$entry) === false){
    $message[] = "E200 - Your password cannot be change, please contact the administrator.";
  }
  else {
    $message[] = " Your password has been changed. ";
    //mail($records[0]["mail"][0],"Password change notice : ".$user,"Your password has just been changed.");
    }
} 

?>
~~~

~~~ html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
 <title>Change your password</title>
 <style type="text/css">
 body { font-family: Verdana,Arial,Courier New; font-size: 0.7em;  }
 input:focus { background-color: #eee; border-color: red; }
 th { text-align: right; padding: 0.8em; }
 #container { text-align: center; width: 500px; margin: 5% auto; }
 ul { text-align: left; list-style-type: square; }
 .msg { margin: 0 auto; text-align: center; color: navy;  border-top: 1px solid red;  border-bottom: 1px solid red;  }
 </style>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>
<div id="container">
<h2> Change your LDAP password </h2>
<ul>
  <li> Your new password must be 8 characters long and contain at least one letter and one digit. </li>
</ul>
<form method="post">
  <table style="width: 400px; margin: 0 auto;">
    <tr><th>Username:</th><td><input name="username" type="text" size="20" autocomplete="off" /></td></tr>
    <tr><th>Old password:</th><td><input name="oldPassword" type="password" /></td></tr>
    <tr><th>New password:</th><td><input name="newPassword1" type="password" /></td></tr>
    <tr><th>New password (confirm):</th><td><input name="newPassword2" type="password" /></td></tr>
    <tr><td colspan="2" style="text-align: center;" ><input name="submitted" type="submit" value="Change Password"/></td></tr>
  </table>
</form>
<div class="msg">
<?php
if (isset($_POST["submitted"])) {
  $rdn = sprintf($dn,$_POST["username"]);
  changePassword($server,$dn,$_POST["username"],$_POST["oldPassword"],$_POST["newPassword1"],$_POST["newPassword2"]);
  foreach ( $message as $one ) { echo "<p>$one</p>"; }
}
?>
</div>
</div>
</body></html>
~~~










