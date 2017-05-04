---
layout: post
title: PHP 升级到 5.6.28，导致 PHP LDAP ADMIN 不可用
categories: [cm, ldap]
tags: [openldap, php, phpldapadmin]
---

修改 phpldapadmin 源码，问题解决。


{% highlight diff linenos %}
diff --git a/config/config.php b/config/config.php
index 4f64ccb..5447e3f 100755
--- a/config/config.php
+++ b/config/config.php
@@ -379,7 +379,7 @@ $servers->setValue('login','bind_pass','Homei$3fe');

 /* Default password hashing algorithm. One of md5, ssha, sha, md5crpyt, smd5,
    blowfish, crypt or leave blank for now default algorithm. */
-// $servers->setValue('appearance','password_hash','md5');
+// $servers->setValue('appearance','password_hash_pla','md5');

 /* If you specified 'cookie' or 'session' as the auth_type above, you can
    optionally specify here an attribute to use when logging in. If you enter
@@ -546,7 +546,7 @@ $servers->setValue('sasl','authz_id_regex','/^uid=([^,]+)(.+)/i');
 $servers->setValue('sasl','authz_id_replacement','$1');
 $servers->setValue('sasl','props',null);

-$servers->setValue('appearance','password_hash','md5');
+$servers->setValue('appearance','password_hash_pla','md5');
 $servers->setValue('login','attr','dn');
 $servers->setValue('login','fallback_dn',false);
 $servers->setValue('login','class',null);
diff --git a/config/config.php.example b/config/config.php.example
index 5b6fdb8..f2cea59 100755
--- a/config/config.php.example
+++ b/config/config.php.example
@@ -379,7 +379,7 @@ $servers->setValue('server','name','My LDAP Server');

 /* Default password hashing algorithm. One of md5, ssha, sha, md5crpyt, smd5,
    blowfish, crypt or leave blank for now default algorithm. */
-// $servers->setValue('appearance','password_hash','md5');
+// $servers->setValue('appearance','password_hash_pla','md5');

 /* If you specified 'cookie' or 'session' as the auth_type above, you can
    optionally specify here an attribute to use when logging in. If you enter
@@ -546,7 +546,7 @@ $servers->setValue('sasl','authz_id_regex','/^uid=([^,]+)(.+)/i');
 $servers->setValue('sasl','authz_id_replacement','$1');
 $servers->setValue('sasl','props',null);

-$servers->setValue('appearance','password_hash','md5');
+$servers->setValue('appearance','password_hash_pla','md5');
 $servers->setValue('login','attr','dn');
 $servers->setValue('login','fallback_dn',false);
 $servers->setValue('login','class',null);
diff --git a/lib/PageRender.php b/lib/PageRender.php
index 7d86a54..0858108 100755
--- a/lib/PageRender.php
+++ b/lib/PageRender.php
@@ -287,7 +287,7 @@ class PageRender extends Visitor {
                                                break;

                                        default:
-                                               $vals[$i] = password_hash($passwordvalue,$enc);
+                                               $vals[$i] = password_hash_pla($passwordvalue,$enc);
                                }

                                $vals = array_unique($vals);
@@ -957,7 +957,7 @@ class PageRender extends Visitor {
                if (trim($val))
                        $enc_type = get_enc_type($val);
                else
-                       $enc_type = $server->getValue('appearance','password_hash');
+                       $enc_type = $server->getValue('appearance','password_hash_pla');

                $obfuscate_password = obfuscate_password_display($enc_type);

@@ -982,7 +982,7 @@ class PageRender extends Visitor {
                if (trim($val))
                        $enc_type = get_enc_type($val);
                else
-                       $enc_type = $server->getValue('appearance','password_hash');
+                       $enc_type = $server->getValue('appearance','password_hash_pla');

                echo '<table cellspacing="0" cellpadding="0"><tr><td valign="top">';

diff --git a/lib/TemplateRender.php b/lib/TemplateRender.php
index f761b86..0a74913 100755
--- a/lib/TemplateRender.php
+++ b/lib/TemplateRender.php
@@ -2466,7 +2466,7 @@ function deleteAttribute(attrName,friendlyName,i)
                if ($val = $attribute->getValue($i))
                        $default = get_enc_type($val);
                else
-                       $default = $this->getServer()->getValue('appearance','password_hash');
+                       $default = $this->getServer()->getValue('appearance','password_hash_pla');

                if (! $attribute->getPostValue())
                        printf('<input type="hidden" name="post_value[%s][]" value="%s" />',$attribute->getName(),$i);
diff --git a/lib/ds_ldap.php b/lib/ds_ldap.php
index c346660..38efae5 100755
--- a/lib/ds_ldap.php
+++ b/lib/ds_ldap.php
@@ -1117,12 +1117,20 @@ class ldap extends DS {
                if (is_array($dn)) {
                        $a = array();
                        foreach ($dn as $key => $rdn)
-                               $a[$key] = preg_replace('/\\\([0-9A-Fa-f]{2})/e',"''.chr(hexdec('\\1')).''",$rdn);
+                               // The /e modifier is deprecated, use preg_replace_callback instead
+                               // $a[$key] = preg_replace('/\\\([0-9A-Fa-f]{2})/e',"''.chr(hexdec('\\1')).''",$rdn);
+                               $a[$key] = preg_replace_callback('/\\\([0-9A-Fa-f]{2})/',function ($m){
+                                       ''.chr(hexdec('\\1')).'';
+                               }

                        return $a;

                }
-                       return preg_replace('/\\\([0-9A-Fa-f]{2})/e',"''.chr(hexdec('\\1')).''",$dn);
+                       // The /e modifier is deprecated, use preg_replace_callback instead
+                       // return preg_replace('/\\\([0-9A-Fa-f]{2})/e',"''.chr(hexdec('\\1')).''",$dn);
+                       return preg_replace('/\\\([0-9A-Fa-f]{2})/',function ($m){
+                               "''.chr(hexdec('\\1')).''";
+                       }
        }

        public function getRootDSE($method=null) {
diff --git a/lib/ds_ldap_pla.php b/lib/ds_ldap_pla.php
index 7ece393..c63d26f 100755
--- a/lib/ds_ldap_pla.php
+++ b/lib/ds_ldap_pla.php
@@ -16,7 +16,7 @@ class ldap_pla extends ldap {
        function __construct($index) {
                parent::__construct($index);

-               $this->default->appearance['password_hash'] = array(
+               $this->default->appearance['password_hash_pla'] = array(
                        'desc'=>'Default HASH to use for passwords',
                        'default'=>'md5');

diff --git a/lib/functions.php b/lib/functions.php
index 56d8bf3..e218312 100755
--- a/lib/functions.php
+++ b/lib/functions.php
@@ -2127,7 +2127,7 @@ function password_types() {
  *        crypt, ext_des, md5crypt, blowfish, md5, sha, smd5, ssha, sha512, or clear.
  * @return string The hashed password.
  */
-function password_hash($password_clear,$enc_type) {
+function password_hash_pla($password_clear,$enc_type) {
        if (DEBUG_ENABLED && (($fargs=func_get_args())||$fargs='NOARGS'))
                debug_log('Entered (%%)',1,0,__FILE__,__LINE__,__METHOD__,$fargs);

@@ -2318,7 +2318,7 @@ function password_check($cryptedpassword,$plainpassword,$attribute='userpassword

                # SHA crypted passwords
                case 'sha':
-                       if (strcasecmp(password_hash($plainpassword,'sha'),'{SHA}'.$cryptedpassword) == 0)
+                       if (strcasecmp(password_hash_pla($plainpassword,'sha'),'{SHA}'.$cryptedpassword) == 0)
                                return true;
                        else
                                return false;
@@ -2327,7 +2327,7 @@ function password_check($cryptedpassword,$plainpassword,$attribute='userpassword

                # MD5 crypted passwords
                case 'md5':
-                       if( strcasecmp(password_hash($plainpassword,'md5'),'{MD5}'.$cryptedpassword) == 0)
+                       if( strcasecmp(password_hash_pla($plainpassword,'md5'),'{MD5}'.$cryptedpassword) == 0)
                                return true;
                        else
                                return false;
@@ -2392,7 +2392,7 @@ function password_check($cryptedpassword,$plainpassword,$attribute='userpassword

                # SHA512 crypted passwords
                case 'sha512':
-                       if (strcasecmp(password_hash($plainpassword,'sha512'),'{SHA512}'.$cryptedpassword) == 0)
+                       if (strcasecmp(password_hash_pla($plainpassword,'sha512'),'{SHA512}'.$cryptedpassword) == 0)
                                return true;
                        else
:
                                return false;
@@ -2565,12 +2565,20 @@ function dn_unescape($dn) {
                $a = array();

                foreach ($dn as $key => $rdn)
-                       $a[$key] = preg_replace('/\\\([0-9A-Fa-f]{2})/e',"''.chr(hexdec('\\1')).''",$rdn);
+                       // The /e modifier is deprecated, use preg_replace_callback instead
+                       // $a[$key] = preg_replace('/\\\([0-9A-Fa-f]{2})/e',"''.chr(hexdec('\\1')).''",$rdn);
+                       $a[$key] = preg_replace_callback('/\\\([0-9A-Fa-f]{2})/',function ($m){
+                               "''.chr(hexdec('\\1')).''";
+                       }

                return $a;

        }
-               return preg_replace('/\\\([0-9A-Fa-f]{2})/e',"''.chr(hexdec('\\1')).''",$dn);
+               // The /e modifier is deprecated, use preg_replace_callback instead
+               // return preg_replace('/\\\([0-9A-Fa-f]{2})/e',"''.chr(hexdec('\\1')).''",$dn);
+               return preg_replace_callback('/\\\([0-9A-Fa-f]{2})/',function ($m){
+                       "''.chr(hexdec('\\1')).''";
+               }
        }
 }

{% endhighlight %}


