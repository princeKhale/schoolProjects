
public abstract class IONeuron extends Neuron{
	private String name;
	
	public IONeuron(String _name){
		super();
		setName(_name);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
