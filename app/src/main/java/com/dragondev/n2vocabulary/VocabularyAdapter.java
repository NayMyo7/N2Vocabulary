package com.dragondev.n2vocabulary;


import android.content.Context;
import android.graphics.Typeface;
import android.speech.tts.TextToSpeech;
import android.support.v7.widget.RecyclerView;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.dragondev.n2vocabulary.model.Vocabulary;

import java.util.ArrayList;
import java.util.Locale;

/**
 * Created by Nay Myo on 09-Dec-17.
 */

public class VocabularyAdapter extends RecyclerView.Adapter<VocabularyAdapter.VocabularyViewHolder> {
    LayoutInflater inflater;
    Context context;
    ArrayList<Vocabulary> vocabList;

    String fontType;
    Boolean speakFlag;
    TextToSpeech tts = null;
    Typeface mTypeface;

    public VocabularyAdapter(Context context, ArrayList<Vocabulary> vocabList) {
        this.context = context;
        this.vocabList = vocabList;
        inflater = LayoutInflater.from(context);

        fontType = MainActivity.pref.getString("fontType", "Zawgyi");
        speakFlag = MainActivity.pref.getBoolean("jpSpeech", true);

        if (fontType.equals("Zawgyi")) {
            mTypeface = Typeface.createFromAsset(context.getAssets(), "fonts/zawgyi1.ttf");
        } else {
            mTypeface = Typeface.createFromAsset(context.getAssets(), "fonts/mm3.ttf");
        }
    }

    @Override
    public VocabularyViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.vocabulary_layout, parent, false);
        VocabularyViewHolder holder = new VocabularyViewHolder(view);
        return holder;
    }

    @Override
    public void onBindViewHolder(final VocabularyViewHolder holder, final int position) {
        final Vocabulary vocab = vocabList.get(position);
        holder.txtNo.setText(String.valueOf(vocab.getNo()));
        holder.txtKanji.setText(vocab.getKanji());
        if (TextUtils.isEmpty(vocab.getFurigana())) {
            holder.txtFuri.setText(vocab.getKanji());
        } else {
            holder.txtFuri.setText(vocab.getFurigana());
        }

        holder.txtMeaning.setTypeface(mTypeface);
        if (fontType.equals("Zawgyi")) {
            holder.txtMeaning.setText(vocab.getZawgyi());
        } else {
            holder.txtMeaning.setText(vocab.getUnicode());
        }

        if (vocab.getFavourite() == 0) {
            holder.txtNo.setBackgroundResource(R.drawable.circle);
        } else {
            holder.txtNo.setBackgroundResource(R.drawable.star);
        }

        if (speakFlag) {
            holder.vContent.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {

                    //stop previous speech if exist
                    if (tts != null)
                        tts.stop();

                    tts = new TextToSpeech(context.getApplicationContext(), new TextToSpeech.OnInitListener() {

                        @Override
                        public void onInit(int status) {
                            if (status == TextToSpeech.SUCCESS) {
                                tts.setLanguage(Locale.JAPAN);
                                String toSpeak = vocab.getKanji();
                                tts.speak(toSpeak, TextToSpeech.QUEUE_FLUSH, null);
                            } else {
                                Toast.makeText(context, "Do not support text to speech!", Toast.LENGTH_SHORT).show();
                            }
                        }
                    });
                }
            });
        }

        holder.vContent.setOnLongClickListener(new View.OnLongClickListener() {
            @Override
            public boolean onLongClick(View v) {

                if (vocab.getFavourite() == 0) {
                    vocab.setFavourite(1);
                    Toast.makeText(context, "Favourite added " + vocab.getNo(), Toast.LENGTH_SHORT).show();
                    v.findViewById(R.id.no).setBackgroundResource(R.drawable.star);
                    MainActivity.dbHelper.markFavourite(vocab.getId());
                } else {
                    vocab.setFavourite(0);
                    Toast.makeText(context, "Favourite removed " + vocab.getNo() + "!", Toast.LENGTH_SHORT).show();
                    v.findViewById(R.id.no).setBackgroundResource(R.drawable.circle);
                    MainActivity.dbHelper.removeFavourite(vocab.getId());
                }

                return true;
            }
        });
    }

    @Override
    public int getItemCount() {
        return vocabList.size();
    }

    class VocabularyViewHolder extends RecyclerView.ViewHolder {

        RelativeLayout vContent;
        TextView txtNo, txtKanji, txtFuri, txtMeaning;

        public VocabularyViewHolder(View itemView) {
            super(itemView);
            vContent = (RelativeLayout) itemView.findViewById(R.id.vocabulary_content);
            txtNo = (TextView) itemView.findViewById(R.id.no);
            txtKanji = (TextView) itemView.findViewById(R.id.kanji);
            txtFuri = (TextView) itemView.findViewById(R.id.furi);
            txtMeaning = (TextView) itemView.findViewById(R.id.meaning);
        }
    }


}
