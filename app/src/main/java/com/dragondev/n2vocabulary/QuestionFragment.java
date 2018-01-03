package com.dragondev.n2vocabulary;

import android.app.Dialog;
import android.os.Bundle;
import android.speech.tts.TextToSpeech;
import android.support.v4.app.Fragment;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ListView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.RatingBar;
import android.widget.TextView;
import android.widget.Toast;

import com.dragondev.n2vocabulary.model.Question;

import java.util.ArrayList;
import java.util.Locale;

public class QuestionFragment extends Fragment {

    ArrayList<Question> qList;
    Question question;
    int[] answers;
    int qid = 0;
    int count = 0;

    Button speaker;
    TextView qNo, qView;
    RadioGroup optionGroup;
    RadioButton option1, option2, option3, option4;
    Button previous, finish, next;

    TextToSpeech tts = null;

    Dialog scoreDialog, qListDialog;
    TextView textScore, textResult;
    RatingBar ratingBar;
    Button check, ok;


    public QuestionFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, final ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_question, container, false);

        int week = getArguments().getInt("mWeek");
        int day = getArguments().getInt("mDay");
        qList = MainActivity.dbHelper.retrieveQuestion(week, day);

        count = qList.size();
        answers = new int[count];

        if (qList != null)
            question = qList.get(qid);

        speaker = (Button) view.findViewById(R.id.speak_question);
        qNo = (TextView) view.findViewById(R.id.qno);
        qView = (TextView) view.findViewById(R.id.question);

        optionGroup = (RadioGroup) view.findViewById(R.id.option_group);
        option1 = (RadioButton) view.findViewById(R.id.option1);
        option2 = (RadioButton) view.findViewById(R.id.option2);
        option3 = (RadioButton) view.findViewById(R.id.option3);
        option4 = (RadioButton) view.findViewById(R.id.option4);

        previous = (Button) view.findViewById(R.id.prev);
        finish = (Button) view.findViewById(R.id.finish);
        next = (Button) view.findViewById(R.id.next);

        changeButtonStatus(qid);

        speaker.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                //stop previous speech if exist
                if (tts != null)
                    tts.stop();

                tts = new TextToSpeech(getActivity().getApplicationContext(), new TextToSpeech.OnInitListener() {

                    @Override
                    public void onInit(int status) {
                        if (status == TextToSpeech.SUCCESS) {
                            tts.setLanguage(Locale.JAPAN);
                            String toSpeak = qList.get(qid).getQuestion();
                            tts.speak(toSpeak, TextToSpeech.QUEUE_FLUSH, null);
                        } else {
                            Toast.makeText(getActivity().getApplicationContext(), "Do not support text to speech!", Toast.LENGTH_SHORT).show();
                        }
                    }

                });
            }
        });

        previous.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                //save user answer
                answers[qid] = getSelectedAnswer();

                //move to previous question
                question = qList.get(--qid);
                setQuestion();

                //make selected if already answered
                optionGroup.clearCheck();
                if (answers[qid] != 0)
                    makeSelectedOption(answers[qid]);

                //check for first and last question for Previous and Next
                changeButtonStatus(qid);
            }
        });

        next.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                //save user answer
                answers[qid] = getSelectedAnswer();

                //move to next question
                question = qList.get(++qid);
                setQuestion();

                //make selected if already answered
                optionGroup.clearCheck();
                if (answers[qid] != 0)
                    makeSelectedOption(answers[qid]);

                //check for first and last question for Previous and Next
                changeButtonStatus(qid);
            }
        });

        finish.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                int score = 0;
                float scoreRate = 0, stepSize = 0;

                //save user answer
                answers[qid] = getSelectedAnswer();

                for (int i = 0; i < count; i++) {
                    if (answers[i] == qList.get(i).getAnswer())
                        score++;
                }

                stepSize = ((1 * 5.0f) / count);
                scoreRate = (score * 5.0f) / count;

                scoreDialog = new Dialog(container.getContext(), R.style.ScoreDialog);
                scoreDialog.setContentView(R.layout.dialog_score);
                scoreDialog.setCancelable(true);

                textResult = (TextView) scoreDialog.findViewById(R.id.text_result);
                ratingBar = (RatingBar) scoreDialog.findViewById(R.id.rating_bar);
                check = (Button) scoreDialog.findViewById(R.id.check);
                ok = (Button) scoreDialog.findViewById(R.id.ok);

                textResult.setText(score + "/" + count);

                ratingBar.setStepSize(stepSize);
                ratingBar.setRating(scoreRate);

                ok.setOnClickListener(new View.OnClickListener() {

                    @Override
                    public void onClick(View v) {
                        scoreDialog.dismiss();
                        //make selected if already answered
                        optionGroup.clearCheck();
                        if (answers[qid] != 0)
                            makeSelectedOption(answers[qid]);

                    }
                });

                check.setOnClickListener(new View.OnClickListener() {

                    @Override
                    public void onClick(View v) {
                        scoreDialog.dismiss();
                        //make selected if already answered
                        optionGroup.clearCheck();
                        if (answers[qid] != 0)
                            makeSelectedOption(answers[qid]);

                        qListDialog = new Dialog(container.getContext(), android.R.style.Theme_Translucent_NoTitleBar_Fullscreen);
                        qListDialog.getWindow().setBackgroundDrawableResource(R.color.white);
                        qListDialog.setContentView(R.layout.question_list_layout);
                        qListDialog.setCancelable(true);

                        QuestionAdapter qAdapter = new QuestionAdapter(container.getContext(), qList, answers);
                        ListView qListView = (ListView) qListDialog.findViewById(R.id.list);
                        qListView.setAdapter(qAdapter);

                        qListDialog.show();
                    }
                });

                scoreDialog.show();
            }
        });

        setQuestion();

        return view;
    }

    //Make radio button selected if already answer
    protected void makeSelectedOption(int i) {
        switch (i) {
            case 1:
                option1.setChecked(true);
                break;

            case 2:
                option2.setChecked(true);
                break;

            case 3:
                option3.setChecked(true);
                break;

            default:
                option4.setChecked(true);
                break;
        }
    }

    //Get user selected answer
    protected int getSelectedAnswer() {
        int ans;
        if (option1.isChecked()) {
            ans = 1;
            option1.setChecked(false);
        } else if (option2.isChecked()) {
            ans = 2;
            option2.setChecked(false);
        } else if (option3.isChecked()) {
            ans = 3;
            option3.setChecked(false);
        } else if (option4.isChecked()) {
            ans = 4;
            option4.setChecked(false);
        } else {
            ans = 0;
        }

        //Log.i("User answer", String.valueOf(ans));
        return ans;
    }


    //Change button status
    private void changeButtonStatus(int id) {
        if (id == 0)
            previous.setEnabled(false);
        else
            previous.setEnabled(true);
        if (id == count - 1)
            next.setEnabled(false);
        else
            next.setEnabled(true);
    }

    //Set current question
    private void setQuestion() {
        speaker.setText(question.getNo() + "/" + count);
        qNo.setText(question.getNo() + ".");
        qView.setText(question.getQuestion());
        option1.setText(question.getOption1());
        option2.setText(question.getOption2());
        if (TextUtils.isEmpty(question.getOption3())) {
            option3.setVisibility(View.GONE);
            option4.setVisibility(View.GONE);
        } else {
            option3.setText(question.getOption3());
            option4.setText(question.getOption4());
            option3.setVisibility(View.VISIBLE);
            option4.setVisibility(View.VISIBLE);
        }
    }

    @Override
    public void onResume() {
        super.onResume();
    }

}
