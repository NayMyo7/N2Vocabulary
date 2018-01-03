package com.dragondev.n2vocabulary;

import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.widget.Toolbar;
import android.text.TextPaint;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ExpandableListAdapter;
import android.widget.ExpandableListView;
import android.widget.FrameLayout;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import ee.yutani.furiganaview.FuriganaView;

public class DrawerFragment extends Fragment {
    DrawerLayout mDrawer;
    ActionBarDrawerToggle mToggle;
    Toolbar tBar;
    FrameLayout mContentFrame;
    FuriganaView appTitle;
    TextView tv;
    TextPaint tp;

    ExpandableListView mExpandableListView;
    ExpandableListAdapter mExpandableListAdapter;
    List<String> mExpandableListTitle;
    Map<String, List<String>> mExpandableListData;

    int lastExpandPosition = -1;
    int selectedIndex = 1;
    int mWeek = 0, mDay = 0, mPosition = 1;
    SharedPreferences.Editor edit;

    public DrawerFragment() {

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View v = inflater.inflate(R.layout.fragment_drawer, container, false);
        mExpandableListView = (ExpandableListView) v.findViewById(R.id.nav_List);

        tv = new TextView(getActivity());
        tv.setTextAppearance(getActivity(), android.R.style.TextAppearance_DeviceDefault_Medium);
        tp = tv.getPaint();
        tp.setColor(Color.WHITE);
        tp.setTypeface(Typeface.DEFAULT_BOLD);

        return v;
    }


    public void setupDrawer(DrawerLayout drawer, Toolbar bar, FrameLayout content_frame) {
        mDrawer = drawer;
        tBar = bar;
        appTitle = (FuriganaView) tBar.findViewById(R.id.appTitle);
        mContentFrame = content_frame;
        mToggle = new ActionBarDrawerToggle(getActivity(), mDrawer, tBar, R.string.drawer_open, R.string.drawer_close) {
            @Override
            public void onDrawerOpened(View drawerView) {
                super.onDrawerOpened(drawerView);
                mExpandableListView.expandGroup(mWeek == 0 ? mWeek : mWeek - 1);
                mExpandableListView.setItemChecked(selectedIndex, true);

                MainActivity.hideFAB();
            }

            @Override
            public void onDrawerClosed(View drawerView) {
                super.onDrawerClosed(drawerView);
            }
        };
        mDrawer.setDrawerListener(mToggle);
        mDrawer.post(new Runnable() {
            @Override
            public void run() {
                mToggle.syncState();
            }
        });

        edit = MainActivity.pref.edit();
        mWeek = MainActivity.pref.getInt("week", 1);
        mDay = MainActivity.pref.getInt("day", 1);
        mPosition = MainActivity.pref.getInt("position", 1);
        selectedIndex = MainActivity.pref.getInt("index", 1);
        showContent();
    }

    public void addDrawerItems() {
        mExpandableListData = ExpandableListDataSource.getData(getActivity());
        mExpandableListTitle = new ArrayList(mExpandableListData.keySet());

        mExpandableListAdapter = new CustomExpandableListAdapter(getActivity(), mExpandableListTitle, mExpandableListData);
        mExpandableListView.setAdapter(mExpandableListAdapter);

        mExpandableListView.setOnGroupExpandListener(new ExpandableListView.OnGroupExpandListener() {
            @Override
            public void onGroupExpand(int groupPosition) {
                if (lastExpandPosition != -1 && lastExpandPosition != groupPosition) {
                    mExpandableListView.collapseGroup(lastExpandPosition);
                }
                lastExpandPosition = groupPosition;

                //Checked the current group is current mWeek to ensure selected item
                if (mWeek == groupPosition + 1)
                    mExpandableListView.setItemChecked(selectedIndex, true);
                else
                    mExpandableListView.setItemChecked(selectedIndex, false);
            }
        });

        mExpandableListView.setOnGroupCollapseListener(new ExpandableListView.OnGroupCollapseListener() {
            @Override
            public void onGroupCollapse(int groupPosition) {

            }
        });

        mExpandableListView.setOnChildClickListener(new ExpandableListView.OnChildClickListener() {
            @Override
            public boolean onChildClick(ExpandableListView parent, View v, int groupPosition, int childPosition, long id) {

                selectedIndex = parent.getFlatListPosition(ExpandableListView
                        .getPackedPositionForChild(groupPosition, childPosition));
                parent.setItemChecked(selectedIndex, true);

                edit.putInt("index", selectedIndex);

                //Get mWeek and mDay for expandable list
                mWeek = groupPosition + 1;
                mDay = childPosition + 1;

                edit.putInt("week", mWeek);
                edit.putInt("day", mDay);
                edit.commit();

                showContent();
                mDrawer.closeDrawers();
                return false;
            }
        });
    }

    private void showContent() {
        tBar.setTitle("");
        String mTitle = mExpandableListAdapter.getChild(mWeek - 1, mDay - 1).toString();
        mTitle = mTitle.substring(9, mTitle.length());
        mTitle = mWeek + "-" + mDay + mTitle;
        appTitle.text_set(tp, mTitle, 0, 0);

        if (mDay == 7) {
            loadQuestionView();
        } else {
            loadVocabularyView();
        }
    }

    private void loadVocabularyView() {
        Bundle data = new Bundle();
        data.putInt("mWeek", mWeek);
        data.putInt("mDay", mDay);

        FragmentManager fragmentManager = getFragmentManager();
        FragmentTransaction ft = fragmentManager.beginTransaction();
        VocabularyFragment vFragment = new VocabularyFragment();
        vFragment.setArguments(data);
        ft.replace(mContentFrame.getId(), vFragment);
        ft.commit();
    }

    private void loadQuestionView() {
        Bundle data = new Bundle();
        data.putInt("mWeek", mWeek);
        data.putInt("mDay", mDay);

        FragmentManager fragmentManager = getFragmentManager();
        FragmentTransaction ft = fragmentManager.beginTransaction();
        QuestionFragment qFragment = new QuestionFragment();
        qFragment.setArguments(data);
        ft.replace(mContentFrame.getId(), qFragment);
        ft.commit();
    }
}
