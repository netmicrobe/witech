---
layout: post
title: 获取当前系统的API LEVEL
description: 
categories: [android, dev]
tags: [android]
---

参考：

* <http://stackoverflow.com/a/17285119>
* <http://stackoverflow.com/a/5086706>
* <http://stackoverflow.com/a/19874645>
* <http://stackoverflow.com/questions/20067508/get-real-path-from-uri-android-kitkat-new-storage-access-framework/20559175#20559175>
* <https://issues.apache.org/jira/browse/CB-5398>


## 呼出相册

{% highlight java %}
@Override
public void onClick(View v) {

  dialog.dismiss();
  // htc 7109机型
  // Intent intent = new Intent(Intent.ACTION_PICK,
  // android.provider.MediaStore.Images.Media.INTERNAL_CONTENT_URI);
  
  // 通适版本
  Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
  intent.addCategory(Intent.CATEGORY_OPENABLE);
  intent.setType("image/*");
  startActivityForResult(intent,
          Const.CATEGORY_OPENABLE_REQUEST_CODE);
            
  // 联想A505e，A500e机型
  //                try {
  //                    Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
  //                    intent.setType("image/*");
  //                    intent.setClassName("com.android.gallery3d",
  //                            "com.android.gallery3d.app.Gallery");
  //                    startActivityForResult(intent,
  //                            Const.CATEGORY_OPENABLE_REQUEST_CODE);
  //                } catch (Exception e) {
  //                    e.printStackTrace();
  //
  //                }
}
{% endhighlight %}
            
## 读取相册中选择的图片

{% highlight java %}
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK) {
            switch (requestCode) {
            // 相册
            case Const.CATEGORY_OPENABLE_REQUEST_CODE:
                Cursor cursor = null;
          try {
            Uri uri = data.getData();
            
            String srcFile = null;
            cursor = getContentResolver().query(uri, null, null, null, null);
            if (cursor != null) {
              cursor.moveToFirst();

              int cidx = cursor.getColumnIndex(MediaStore.MediaColumns.DISPLAY_NAME);
              if (cidx > 0) {
                srcFile = cursor.getString(cidx);
              }
            }
            if (srcFile == null) {
              // 必须要读到文件名，否则下面代码不知道图片的格式；有待改进，不应该依赖文件名；
              throw new Exception("CAN'T READ IMAGE FILE DISPLAY NAME!");
            }
            InputStream is = this.getContentResolver().openInputStream(uri);
            // TODO 生成bitmap对sample size也需要做针对大图片的优化。
            Bitmap bitmap = BitmapFactory.decodeStream(is);
            TaskUtils.executeTaskCheck(new UpdateIconTask(bitmap, srcFile), "");
                } catch (Exception e) {
                    e.printStackTrace();
                    ToastUtils.show(EgameTabMycenterActivity.this,
                            R.string.egame_get_pic_error);
                } finally {
                    if (null != cursor) {
                        cursor.close();
                    }
                }
                break;
            // 拍照
            case Const.IMAGE_CAPTURE_REQUEST_CODE: {
                try {
                    // 压缩图片
                    showPDialog();
                    Bitmap bitmap = ImageUtils.decodeFile(Environment
                            .getExternalStorageDirectory() + "/camera.png");
                    TaskUtils.executeTaskCheck(new UpdateIconTask(bitmap,
                            Environment.getExternalStorageDirectory()
                                    + "/camera.png"), "");
                } catch (Exception e) {
                    e.printStackTrace();
                    ToastUtils.show(EgameTabMycenterActivity.this,
                            R.string.egame_get_pic_error);
                }
            }
                break;
            case Const.EGAME_USER_REFRESH_INFO:
                showPDialog();
                listView.setVisibility(View.GONE);
                initViewData();
                break;
            }
        }
    }

{% endhighlight %}


