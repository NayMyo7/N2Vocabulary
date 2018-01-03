package com.dragondev.n2vocabulary;


import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;

import com.dragondev.n2vocabulary.model.Vocabulary;

import java.util.ArrayList;


public class VocabularyFragment extends Fragment {

    RecyclerView recyclerView;
    ArrayList<Vocabulary> vocabList = new ArrayList<>();

    public VocabularyFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_vocabulary, container, false);
        recyclerView = (RecyclerView) view.findViewById(R.id.vocabulary_list);

        int week = getArguments().getInt("mWeek");
        int day = getArguments().getInt("mDay");
        vocabList = MainActivity.dbHelper.retrieveVocabulary(week, day);
        VocabularyAdapter vocabAdapter = new VocabularyAdapter(getActivity(), vocabList);
        recyclerView.setAdapter(vocabAdapter);
        recyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));

        return view;
    }

    @Override
    public void onResume() {
        super.onResume();
    }

}
