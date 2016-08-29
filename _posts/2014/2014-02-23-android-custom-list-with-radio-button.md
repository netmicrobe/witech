---
layout: post
title: Android：自定义带Radio的listview
description: 
categories: [android, dev]
tags: [android]
---

### 在activity的layout中定义listview

{% highlight xml %}
<ListView 
    android:id="@+id/list"
    android:layout_width="fill_parent"
    android:layout_height="fill_parent"
    android:layout_below="@id/buy"
    android:layout_alignLeft="@id/feeno_label"
    android:choiceMode="singleChoice"
    /> <!-- layout_height,不能设置成wrap_content，会导致自定义的adapter的getView连续调用2次！ -->
{% endhighlight %}
    
### 创建自定的list view layout

{% highlight xml %}
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent" >
    
    <TextView
        android:id="@+id/name"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_alignParentLeft="true"
        android:layout_alignParentTop="true"
        /><!-- 显示名称（备注名称） -->
    <TextView
        android:id="@+id/price"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_below="@id/name"
        android:layout_alignLeft="@id/name"
        /><!-- 价格：？【软/硬】 -->

    <RadioButton
        android:id="@+id/radio"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_alignParentRight="true"
        android:layout_centerVertical="true"
        />
    
</RelativeLayout>
{% endhighlight %}

### 创建一个自定的Adapter，重写getView（），指定自定义的list item layout。

{% highlight java %}
    public static class ListAdapter extends BaseAdapter {
        SMS11807MainActivity ctx;
        LayoutInflater lInflater;
        ArrayList<ConsumePoint> cpoints;
        RadioState[] rstates;
        int selected = -1;
        
        public ListAdapter(Context context, ArrayList<ConsumePoint> cps) {
            ctx = (SMS11807MainActivity)context;
            cpoints = cps;
            
            int sz = cps.size();
            rstates = new RadioState[sz];
            for(int i=0; i<sz; ++i) {
                rstates[i] = new RadioState(this, i);
            }
            
            lInflater = (LayoutInflater) ctx
                    .getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        }

        @Override
        public int getCount() {
            return cpoints.size();
        }

        @Override
        public Object getItem(int position) {
            return cpoints.get(position);
        }

        @Override
        public long getItemId(int position) {
            return position;
        }
        
        ConsumePoint getCPoint(int position) {
            return cpoints.get(position);
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {            
            boolean bc = true; // if create view
            if( convertView != null ) {
                ViewHolder vhld = (ViewHolder)convertView.getTag();
                int pos = ((RadioState)(vhld.radio.getTag())).id;
                if( pos == position )
                    bc = false;
            }
            
            View view = null;
            if (bc) {
                view = lInflater.inflate(R.layout.list_item_consume_point, parent, false);
                
                final ViewHolder holder = new ViewHolder();
                holder.name = (TextView) view.findViewById(R.id.name);
                holder.price = (TextView) view.findViewById(R.id.price);
                holder.radio = (RadioButton) view.findViewById(R.id.radio);
                holder.radio.setOnCheckedChangeListener(myCheckChangList);
                holder.radio.setTag(rstates[position]);
                
                view.setTag(holder);
            } else {
                ViewHolder vvh = (ViewHolder)convertView.getTag();
                Log.d(TAG, "last name:" + vvh.price.getText());
                Log.d(TAG, " ========= now name:" + getCPoint(position).mDisplayName);
                view = convertView;
                ((ViewHolder)view.getTag()).radio.setTag(rstates[position]);
            }
            
            ViewHolder vh = (ViewHolder)view.getTag();
            ConsumePoint p = getCPoint(position);
            vh.name.setText(p.mDisplayName + "（" + p.mInvokeName + "）");
            vh.price.setText("价格：" + p.mPrice/100 + "元 【" + (p.mIsRepeatable?"软":"硬") + "】");
            vh.radio.setChecked(rstates[position].isSelected());
            
            return view;
        }
        
        OnCheckedChangeListener myCheckChangList = new OnCheckedChangeListener() {
            public void onCheckedChanged(CompoundButton buttonView,
                    boolean isChecked) {
                Log.d(TAG, "button " + ((RadioState)(buttonView.getTag())).id + " " + isChecked);
                if( isChecked ) {
                    RadioState rs = (RadioState)(buttonView.getTag());
                    rs.setSelected();
                    ctx.updateCurrentCPoint(cpoints.get(rs.id));
                }
            }
        };
        
        static class ViewHolder {
            TextView name;
            TextView price;
            RadioButton radio;
        }
        
        void setSelected( int id ) {
            if( selected >= 0 ) {
                rstates[selected].setUnSelected();
            }
            selected = id;
            this.notifyDataSetChanged();
        }
        
        static class RadioState {
            ListAdapter parent;
            int id;
            boolean bSelected;
            
            RadioState(ListAdapter p, int i) {
                parent = p;
                id = i;
                bSelected = false;
            }
            
            void setSelected() {
                bSelected = true;
                parent.setSelected(id);
            }
            
            void setUnSelected() {
                bSelected = false;
            }
            
            boolean isSelected() {
                return bSelected;
            }
        }
    }//END OF CLASS ListAdapter
{% endhighlight %}

在Activity的onCreate（）中创建adapter示例，设置给listview。


{% highlight java %}
ListAdapter adp = new ListAdapter(this, feefile.mCPoints);
m_listView.setAdapter(adp);
{% endhighlight %}




