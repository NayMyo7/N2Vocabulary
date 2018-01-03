package com.dragondev.n2vocabulary;


import android.app.Activity;
import android.content.Context;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

import com.dragondev.n2vocabulary.model.Question;

import java.util.ArrayList;

public class QuestionAdapter extends ArrayAdapter<Question> {

    Context context;
    ArrayList<Question> questionList;
    Question q;
    int[] answers;
    int userAnswer, correctAnswer;

    TextView qNo, qView;
    RadioGroup optionGroup;
    RadioButton option1, option2, option3, option4;
    ImageView img;

    public QuestionAdapter(Context c, ArrayList<Question> qList, int[] ans) {
        super(c, R.layout.fragment_question, qList);
        context = c;
        questionList = qList;
        answers = ans;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        LayoutInflater inflater = ((Activity) context).getLayoutInflater();
        View v = inflater.inflate(R.layout.question_list_content, null);

        qNo = (TextView) v.findViewById(R.id.qno_list);
        qView = (TextView) v.findViewById(R.id.question_list);
        optionGroup = (RadioGroup) v.findViewById(R.id.option_group_list);
        option1 = (RadioButton) v.findViewById(R.id.option1_list);
        option2 = (RadioButton) v.findViewById(R.id.option2_list);
        option3 = (RadioButton) v.findViewById(R.id.option3_list);
        option4 = (RadioButton) v.findViewById(R.id.option4_list);

        q = questionList.get(position);
        qNo.setText((position + 1) + ". ");
        qView.setText(q.getQuestion());
        option1.setText(q.getOption1());
        option2.setText(q.getOption2());
        if (TextUtils.isEmpty(q.getOption3())) {
            option3.setVisibility(View.GONE);
            option4.setVisibility(View.GONE);
        } else {
            option3.setText(q.getOption3());
            option4.setText(q.getOption4());
        }

        correctAnswer = questionList.get(position).getAnswer();
        switch (correctAnswer) {
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

        userAnswer = answers[position];
        System.out.println("User : " + userAnswer);
        switch (userAnswer) {
            case 0:
                img = (ImageView) v.findViewById(R.id.not_taken_img);
                break;
            case 1:
                img = (ImageView) v.findViewById(R.id.option1_img);
                break;
            case 2:
                img = (ImageView) v.findViewById(R.id.option2_img);
                break;
            case 3:
                img = (ImageView) v.findViewById(R.id.option3_img);
                break;
            case 4:
                img = (ImageView) v.findViewById(R.id.option4_img);
                break;
            default:
                break;
        }

        if (userAnswer == 0)
            img.setImageResource(R.mipmap.ic_not_taken);
        else if (userAnswer == correctAnswer)
            img.setImageResource(R.mipmap.ic_true);
        else
            img.setImageResource(R.mipmap.ic_false);

        img.setVisibility(View.VISIBLE);

        return v;
    }


}
