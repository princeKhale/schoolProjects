import java.util.ArrayList;

public class HiddenNeuron extends Neuron{
	private ArrayList<Edge> outEdges = new ArrayList<Edge>();
	private ArrayList<Edge> inEdges = new ArrayList<Edge>();
	private String function;
	private float sums;
	
	public HiddenNeuron(String function){
		super();
	}

	public ArrayList<Edge> getOutEdges() {
		ArrayList<Edge> temp = new ArrayList<Edge>();
		for(Edge e : outEdges){
			temp.add(e);
		}
		return temp;
	}

	public void addOutEdge(Edge e) {
		this.outEdges.add(e);
	}

	public ArrayList<Edge> getInEdges() {
		ArrayList<Edge> temp = new ArrayList<Edge>();
		for(Edge e : inEdges){
			temp.add(e);
		}
		return temp;
	}
	
	public void addInEdge(Edge e) {
		this.inEdges.add(e);
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
