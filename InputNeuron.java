import java.util.ArrayList;

public  class InputNeuron extends IONeuron{
	private ArrayList<Edge> myOutEdges = new ArrayList<Edge>();
	
	public InputNeuron(String _name) {
		super(_name);
	}

	public ArrayList<Edge> getOutEdges() {
		ArrayList<Edge> temp = new ArrayList<Edge>();
		for(Edge e : myOutEdges){
			temp.add(e);
		}
		return temp;
	}

	public void addOutEdge(Edge e) {
		this.myOutEdges.add(e);
	}
	


}
