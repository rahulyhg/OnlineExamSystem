package model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Test generated by hbm2java
 */
public class Test implements java.io.Serializable {

    private static final long serialVersionUID = 2615932675295599713L;

    private int id;
    private Account owner;
    private String name;
    private Date joinStartTime;
    private Date joinEndTime;
    private int timeLength;
    private int attemptLimit;
    private Set<Attempt> attempts = new HashSet<>(0);
    private Set<Question> questions = new HashSet<>(0);

    public Test() {
    }

    public Test(int id, String name, int timeLength, int attemptLimit) {
        this.id = id;
        this.name = name;
        this.timeLength = timeLength;
        this.attemptLimit = attemptLimit;
    }

    public Test(int id, Account owner, String name, Date joinStartTime, Date joinEndTime, int timeLength, int attemptLimit, Set<Attempt> attempts, Set<Question> questions) {
        this.id = id;
        this.owner = owner;
        this.name = name;
        this.joinStartTime = joinStartTime;
        this.joinEndTime = joinEndTime;
        this.timeLength = timeLength;
        this.attemptLimit = attemptLimit;
        this.attempts = attempts;
        this.questions = questions;
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Account getOwner() {
        return this.owner;
    }

    public void setOwner(Account owner) {
        this.owner = owner;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getJoinStartTime() {
        return this.joinStartTime;
    }

    public void setJoinStartTime(Date joinStartTime) {
        this.joinStartTime = joinStartTime;
    }

    public Date getJoinEndTime() {
        return this.joinEndTime;
    }

    public void setJoinEndTime(Date joinEndTime) {
        this.joinEndTime = joinEndTime;
    }

    public int getTimeLength() {
        return this.timeLength;
    }

    public void setTimeLength(int timeLength) {
        this.timeLength = timeLength;
    }

    public int getAttemptLimit() {
        return this.attemptLimit;
    }

    public void setAttemptLimit(int attemptLimit) {
        this.attemptLimit = attemptLimit;
    }

    public Set<Attempt> getAttempts() {
        return this.attempts;
    }

    public void setAttempts(Set<Attempt> attempts) {
        this.attempts = attempts;
    }

    public Set<Question> getQuestions() {
        return this.questions;
    }

    public void setQuestions(Set<Question> questions) {
        this.questions = questions;
    }

}