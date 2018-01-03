package com.dragondev.n2vocabulary.database;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import com.dragondev.n2vocabulary.model.Question;
import com.dragondev.n2vocabulary.model.Vocabulary;

public class DatabaseHelper extends SQLiteOpenHelper {

    private static final String DB_NAME = "N2Vocabulary.sqlite";
    private static final String DB_PATH_SUFFIX = "/database/";
    private SQLiteDatabase myDB;
    private Context context;

    public DatabaseHelper(Context context) throws IOException {
        super(context, DB_NAME, null, 1);
        this.context = context;
    }

    //Open database
    public void openDatabase() {

        String dbPath = context.getApplicationInfo().dataDir + DB_PATH_SUFFIX + DB_NAME;
        File dbFile = new File(dbPath);
        Log.i("dbPath", dbPath + "\t==\t" + dbFile.getPath());

        if (!dbFile.exists()) {
            try {
                Log.i("Task", "Copying...");
                File dbDirectory = new File(context.getApplicationInfo().dataDir + DB_PATH_SUFFIX);
                dbDirectory.mkdir();
                copyDatabase(dbFile);
            } catch (IOException e) {
                throw new RuntimeException("Error creating source database", e);
            }
        }

        myDB = SQLiteDatabase.openDatabase(dbFile.getPath(), null, SQLiteDatabase.OPEN_READWRITE);
    }

    //Copy database if not exist
    private void copyDatabase(File dbFile) throws IOException {

        InputStream is = context.getAssets().open(DB_NAME);
        OutputStream os = new FileOutputStream(dbFile);

        byte[] buffer = new byte[1024];
        int length;
        while ((length = is.read(buffer)) > 0) {
            os.write(buffer, 0, length);
            Log.d("buffer", String.valueOf(length));
        }

        os.flush();
        os.close();
        is.close();
    }


    //Close the database
    public void closeDatabase() {
        myDB.close();
    }

    @Override
    public void onCreate(SQLiteDatabase arg0) {
        // TODO Auto-generated method stub

    }

    @Override
    public void onUpgrade(SQLiteDatabase arg0, int arg1, int arg2) {
        // TODO Auto-generated method stub

    }

    public ArrayList<Vocabulary> retrieveVocabulary(int week, int day) {
        ArrayList<Vocabulary> vocabList = new ArrayList<Vocabulary>();

        Cursor c = null;
        String sql = "SELECT * FROM VOCABULARY WHERE WEEK=? AND DAY=?";
        String[] args = {String.valueOf(week), String.valueOf(day)};
        c = myDB.rawQuery(sql, args);

        c.moveToFirst();
        while (!c.isAfterLast()) {
            Vocabulary v = new Vocabulary();
            v.setId(c.getInt(c.getColumnIndex("ID")));
            v.setNo(c.getInt(c.getColumnIndex("WORD_NO")));
            v.setKanji(c.getString(c.getColumnIndex("KANJI")));
            v.setFurigana(c.getString(c.getColumnIndex("FURIGANA")));
            v.setZawgyi(c.getString(c.getColumnIndex("ZAWGYI")));
            v.setUnicode(c.getString(c.getColumnIndex("UNICODE")));
            int index = c.getColumnIndex("FAVOURITE");
            if (!c.isNull(index))
                v.setFavourite(c.getInt(index));
            vocabList.add(v);
            c.moveToNext();
        }
        c.close();

        return vocabList;
    }

    public ArrayList<Question> retrieveQuestion(int week, int day) {
        ArrayList<Question> qList = new ArrayList<Question>();

        Log.i("Question Helper", "Retrieving questions ...");
        Cursor c = null;
        String sql = "SELECT * FROM QUESTION WHERE WEEK=? AND DAY=?";
        String[] args = {String.valueOf(week), String.valueOf(day)};
        c = myDB.rawQuery(sql, args);

        Log.i("Question Finished", "Retrieving questions Retrieved");
        c.moveToFirst();
        while (!c.isAfterLast()) {
            Question q = new Question();
            q.setNo(c.getInt(c.getColumnIndex("QUESTION_NO")));
            q.setQuestion(c.getString(c.getColumnIndex("QUESTION")));
            q.setOption1(c.getString(c.getColumnIndex("OPTION1")));
            q.setOption2(c.getString(c.getColumnIndex("OPTION2")));
            q.setOption3(c.getString(c.getColumnIndex("OPTION3")));
            q.setOption4(c.getString(c.getColumnIndex("OPTION4")));
            q.setAnswer(c.getInt(c.getColumnIndex("ANSWER")));
            qList.add(q);
            c.moveToNext();
        }
        c.close();

        return qList;
    }

    public void markFavourite(int id) {
        String table = "VOCABULARY";
        ContentValues values = new ContentValues();
        values.put("FAVOURITE", 1);
        String whereClause = "ID=?";
        String[] whereArgs = {String.valueOf(id)};
        myDB.update(table, values, whereClause, whereArgs);
        Log.d("Favourite", "Mark favourite : " + id);
    }

    public void removeFavourite(int id) {
        String table = "VOCABULARY";
        ContentValues values = new ContentValues();
        values.put("FAVOURITE", 0);
        String whereClause = "ID=?";
        String[] whereArgs = {String.valueOf(id)};
        myDB.update(table, values, whereClause, whereArgs);
        Log.d("Favourite", "Remove favourite : " + id);
    }

    public ArrayList<Vocabulary> retrieveFavourite() {
        ArrayList<Vocabulary> vocabList = new ArrayList<>();

        Cursor c = null;
        String sql = "SELECT * FROM VOCABULARY WHERE FAVOURITE=?";
        String[] args = {String.valueOf(1)};
        c = myDB.rawQuery(sql, args);

        c.moveToFirst();
        while (!c.isAfterLast()) {
            Vocabulary v = new Vocabulary();
            v.setWeek(c.getInt(c.getColumnIndex("WEEK")));
            v.setDay(c.getInt(c.getColumnIndex("DAY")));
            v.setNo(c.getInt(c.getColumnIndex("WORD_NO")));
            v.setKanji(c.getString(c.getColumnIndex("KANJI")));
            v.setFurigana(c.getString(c.getColumnIndex("FURIGANA")));
            v.setZawgyi(c.getString(c.getColumnIndex("ZAWGYI")));
            v.setUnicode(c.getString(c.getColumnIndex("UNICODE")));
            v.setFavourite(1);
            vocabList.add(v);
            c.moveToNext();
        }
        c.close();

        return vocabList;
    }


}
