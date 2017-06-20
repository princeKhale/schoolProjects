
public class Edge {
	private Neuron parent;
	private float weight;
	private float deltaWeight;
	
	public Edge(Neuron _parent, float _weight){
		setParent(_parent);
		setWeight(_weight);
		setDeltaWeight(0);
	}

	public float getWeight() {
		return weight;
	}

	public void setWeight(float weight) {
		this.weight = weight;
	}

	public Neuron getParent() {
		return parent;
	}

	public void setParent(Neuron parent) {
		this.parent = parent;
	}

	public float getDeltaWeight() {
		return deltaWeight;
	}

	public void setDeltaWeight(float deltaWeight) {
		this.deltaWeight = deltaWeight;
	}

}
