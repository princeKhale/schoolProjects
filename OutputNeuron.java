import java.util.ArrayList;

public class OutputNeuron extends IONeuron{
	private ArrayList<Edge> myInEdges = new ArrayList<Edge>();
	private String function;
	private float sums;
	
	public OutputNeuron(String _function, String _name) {
		super(_name);
	}
	
	public ArrayList<Edge> getInEdges() {
		ArrayList<Edge> temp = new ArrayList<Edge>();
		for(Edge e : myInEdges){
			temp.add(e);
		}
		return temp;
	}

	public void addInEdge(Edge e) {
		this.myInEdges.add(e);
	}

	public String getFunction() {
		return function;
	}

	public void setFunction(String function) {
		this.function = function;
	}

	public float getSums() {
		return sums;
	}

	public void setSums(float sums) {
		this.sums = sums;
	}
	
}
