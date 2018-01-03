package com.dragondev.n2vocabulary;

import android.app.Dialog;
import android.os.Build;
import android.os.Bundle;
import android.preference.Preference;
import android.preference.Preference.OnPreferenceClickListener;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.util.TypedValue;
import android.view.MenuItem;
import android.view.ViewGroup;

import java.lang.reflect.Type;

public class SettingsActivity extends AppCompatPreferenceActivity {

    Toolbar toolbar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setupActionBar();

        fixOverlapIssue();

        addPreferencesFromResource(R.xml.settings);
        Preference preference = getPreferenceManager().findPreference("about");
        if (preference != null) {
            preference.setOnPreferenceClickListener(new OnPreferenceClickListener() {

                @Override
                public boolean onPreferenceClick(Preference arg0) {
                    Dialog aboutDialog = new Dialog(SettingsActivity.this, android.R.style.Theme_NoTitleBar);
                    aboutDialog.setContentView(R.layout.about_us);
                    aboutDialog.setCancelable(true);
                    aboutDialog.show();
                    return true;
                }
            });
        } else {
            Log.i("Preference", "null");
        }

    }

    private void fixOverlapIssue() {
        int extraPadding = 0;
        if (Build.VERSION.SDK_INT < 21) {
            extraPadding = 30;
        }
        int horizontalMargin = (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, 2, getResources().getDisplayMetrics());
        int verticalMargin = (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, 2, getResources().getDisplayMetrics());
        int topMargin = (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, getResources().getDimension(R.dimen.activity_vertical_margin) + extraPadding, getResources().getDisplayMetrics());
        getListView().setPadding(horizontalMargin, topMargin, horizontalMargin, verticalMargin);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                this.finish();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    private void setupActionBar() {
        getLayoutInflater().inflate(R.layout.app_bar, (ViewGroup) findViewById(android.R.id.content));
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    }
}
