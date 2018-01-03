package com.dragondev.n2vocabulary.model;

public class Vocabulary {

    //Fields
    private int id;
    private int week;
    private int day;
    private int no;
    private String kanji;
    private String furigana;
    private String zawgyi;
    private String unicode;
    private int favourite;

    //Constructor
    public Vocabulary() {
        super();
    }

    public Vocabulary(int id, int week, int day, int no, String kanji, String furigana,
                      String zawgyi, String unicode, int favourite) {
        super();
        this.id = id;
        this.week = week;
        this.day = day;
        this.no = no;
        this.kanji = kanji;
        this.furigana = furigana;
        this.zawgyi = zawgyi;
        this.unicode = unicode;
        this.favourite = favourite;
    }

    //getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getWeek() {
        return week;
    }

    public void setWeek(int week) {
        this.week = week;
    }

    public int getDay() {
        return day;
    }

    public void setDay(int day) {
        this.day = day;
    }

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getKanji() {
        return kanji;
    }

    public void setKanji(String kanji) {
        this.kanji = kanji;
    }

    public String getFurigana() {
        return furigana;
    }

    public void setFurigana(String furigana) {
        this.furigana = furigana;
    }

    public String getZawgyi() {
        return zawgyi;
    }

    public void setZawgyi(String zawgyi) {
        this.zawgyi = zawgyi;
    }

    public String getUnicode() {
        return unicode;
    }

    public void setUnicode(String unicode) {
        this.unicode = unicode;
    }

    public int getFavourite() {
        return favourite;
    }

    public void setFavourite(int favourite) {
        this.favourite = favourite;
    }

    //to string


    @Override
    public String toString() {
        return "Vocabulary{" +
                "id=" + id +
                ", week=" + week +
                ", day=" + day +
                ", no=" + no +
                ", kanji='" + kanji + '\'' +
                ", furigana='" + furigana + '\'' +
                ", zawgyi='" + zawgyi + '\'' +
                ", unicode='" + unicode + '\'' +
                ", favourite=" + favourite +
                '}';
    }
}
