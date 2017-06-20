
public class Example {
	float hoursSlept, hoursStudied, difficulty, expected;
	public float getDifficulty() {
		return difficulty;
	}
	public void setDifficulty(float difficulty) {
		this.difficulty = difficulty;
	}
	public Example(float _hoursSlept, float _hoursStudied, float _difficulty, float _expected){
		setHoursSlept(_hoursSlept);
		setHoursStudied(_hoursStudied);
		setDifficulty(_difficulty);
		setExpected(_expected);
	}
	public float getHoursSlept() {
		return hoursSlept;
	}
	public void setHoursSlept(float a) {
		this.hoursSlept = a;
	}
	public float getHoursStudied() {
		return hoursStudied;
	}
	public void setHoursStudied(float b) {
		this.hoursStudied = b;
	}
	public float getExpected() {
		return expected;
	}
	public void setExpected(float expected) {
		this.expected = expected;
	}
}
