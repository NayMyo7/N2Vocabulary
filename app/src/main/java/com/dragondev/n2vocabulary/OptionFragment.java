package com.dragondev.n2vocabulary;

import android.app.Fragment;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import com.dragondev.n2vocabulary.utils.DialogUtils;

/**
 * Created by Nay Myo on 10-Dec-17.
 */

public class OptionFragment extends Fragment implements View.OnClickListener {

    Button btnExit;
    Button btnFavourite;
    Button btnSetting;

    public OptionFragment() {
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_option, container, false);

        btnExit = (Button) view.findViewById(R.id.btnExit);
        btnFavourite = (Button) view.findViewById(R.id.btnFavourite);
        btnSetting = (Button) view.findViewById(R.id.btnSetting);

        btnExit.setOnClickListener(this);
        btnFavourite.setOnClickListener(this);
        btnSetting.setOnClickListener(this);

        return view;
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btnExit:
                DialogUtils.showExitDialog(getActivity());
                break;

            case R.id.btnFavourite:
                startActivity(new Intent(getActivity(), FavouriteActivity.class));
                break;

            case R.id.btnSetting:
                startActivity(new Intent(getActivity(), SettingsActivity.class));
                break;
        }
    }
}
