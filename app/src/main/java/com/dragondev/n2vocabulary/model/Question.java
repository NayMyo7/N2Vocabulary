package com.dragondev.n2vocabulary.model;

public class Question {
	int no;
	String question;
	String option1;
	String option2;
	String option3;
	String option4;
	int answer;
	
	//Constructor
	public Question() {
		super();
	}

	public Question(int id, String question, String option1, String option2,
			String option3, String option4, int answer) {
		super();
		this.no = id;
		this.question = question;
		this.option1 = option1;
		this.option2 = option2;
		this.option3 = option3;
		this.option4 = option4;
		this.answer = answer;
	}

	//Getters and Setters
	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getOption1() {
		return option1;
	}

	public void setOption1(String option1) {
		this.option1 = option1;
	}

	public String getOption2() {
		return option2;
	}

	public void setOption2(String option2) {
		this.option2 = option2;
	}

	public String getOption3() {
		return option3;
	}

	public void setOption3(String option3) {
		this.option3 = option3;
	}

	public String getOption4() {
		return option4;
	}

	public void setOption4(String option4) {
		this.option4 = option4;
	}

	public int getAnswer() {
		return answer;
	}

	public void setAnswer(int answer) {
		this.answer = answer;
	}

	
	//to print object Question
	@Override
	public String toString() {
		return "Question [no=" + no + ", question=" + question + ", option1="
				+ option1 + ", option2=" + option2 + ", option3=" + option3
				+ ", option4=" + option4 + ", answer=" + answer + "]";
	}
	
}
