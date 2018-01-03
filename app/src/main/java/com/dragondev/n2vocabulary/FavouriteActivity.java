package com.dragondev.n2vocabulary;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;

import com.dragondev.n2vocabulary.model.Vocabulary;

import java.util.ArrayList;

/**
 * Created by Nay Myo on 11-Dec-17.
 */

public class FavouriteActivity extends AppCompatActivity {
    ArrayList<Vocabulary> favList;

    RecyclerView recyclerView;
    Toolbar tBar;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_favourite);

        tBar = (Toolbar) findViewById(R.id.appBar);
        recyclerView = (RecyclerView) findViewById(R.id.vocabulary_list);

        setSupportActionBar(tBar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        favList = MainActivity.dbHelper.retrieveFavourite();

        VocabularyAdapter vocabAdapter = new VocabularyAdapter(getApplicationContext(), favList);
        recyclerView.setAdapter(vocabAdapter);
        recyclerView.setLayoutManager(new LinearLayoutManager(getApplicationContext()));

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

}

