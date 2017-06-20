import java.util.ArrayList;
import java.util.Random;
/*
* A simple feed-forward neural network that takes in data about the hours spent studying, and sleeping the night before an exam
* and also the general difficulty of the class, and spits out what it perdicts you should get. The training pool is quite small but 
* the network itself trained well and it was a neat project to work on. :)
*/

public class NeuralNetwork {
	public static ArrayList<InputNeuron>  inputNeurons = new ArrayList<InputNeuron>();
	public static ArrayList<OutputNeuron> outputNeurons = new ArrayList<OutputNeuron>();
	public static ArrayList<HiddenNeuron> hiddenNeurons = new ArrayList<HiddenNeuron>();
	static float learningRate = (float).08;
	static ArrayList<Example> newData = new ArrayList<Example>();
	static ArrayList<Example> data = new ArrayList<Example>();
	
	public static void main(String[] args) {
		data.add(new Example(7, 4, 3, (float).88));
		data.add(new Example(5, 0, 1, (float)1.00));
		data.add(new Example(6, 3, 3, (float).80));
		data.add(new Example(7, 1, 2, (float).80));
		data.add(new Example(5, 10, 5,(float).80));
		data.add(new Example(7, 2, 4, (float).55));
		data.add(new Example(7, 0, 2, (float).95));
		data.add(new Example(6, 0, 2, (float).88));
		data.add(new Example(5, 6, 3, (float).75));
		data.add(new Example(8, 3, 3, (float).93));
		data.add(new Example(5, 11, 4, (float).80));
		data.add(new Example(7, 7, 3, (float).95));
		data.add(new Example(4, 6, 3, (float).90));
		data.add(new Example(7, 9, 2, (float).90));
		data.add(new Example(7, 10, 4, (float)1.00));
		data.add(new Example(7, 2, 3, (float).72));
		data.add(new Example(3, 10, 5, (float).59));
		data.add(new Example(6, 3, 5, (float).95));
		data.add(new Example(8, 0, 2, (float).90));
		data.add(new Example(6, 4, 4, (float).84));
		data.add(new Example(6, 4, 4, (float).80));
		data.add(new Example(3, 0, 3, (float).87));
		data.add(new Example(5 , 1 , 2, (float)1.00));
		data.add(new Example(7, 1 , 1, (float).83));
	
		newData.add(new Example(6, 4, 5, (float).80));
		buildNet();
		buildEdges();
		//printStructure();
		Example test = newData.get(0);
		System.out.println(test.getExpected() + ":");
		System.out.println(getResult(test.getHoursSlept(), test.getHoursStudied(),
							test.getDifficulty()));
		System.out.println("Training...");
		for(int i = 0; i < 500000; i++){
			for(Example e : data){
				train(e.getHoursSlept(),e.getHoursStudied(),
						e.getDifficulty(),e.getExpected());
			}
		}
		System.out.println(getResult(test.getHoursSlept(), test.getHoursStudied(),
				test.getDifficulty()));
		//printStructure();
		System.exit(0);
	}
	private static void buildNet() {
		
		//Input Neurons
		inputNeurons.add(new InputNeuron("Hours Slept"));
		inputNeurons.add(new InputNeuron("Hours Studied"));
		inputNeurons.add(new InputNeuron("Difficulty"));
		
		//Hidden Neurons
		hiddenNeurons.add(new HiddenNeuron("Sigmoid"));
		hiddenNeurons.add(new HiddenNeuron("Sigmoid"));
		hiddenNeurons.add(new HiddenNeuron("Sigmoid"));
		hiddenNeurons.add(new HiddenNeuron("Sigmoid"));
		
		//Output Neurons
		outputNeurons.add(new OutputNeuron("Sigmoid", "Output"));
	}
	
	private static void buildEdges() {
		Random r = new Random();
		r.setSeed(4773);
		
		//Build Edges between input and hidden layer
		for(InputNeuron In : inputNeurons){
			for(HiddenNeuron Hn : hiddenNeurons){
				float weight = (float)r.nextGaussian();
				Edge e = new Edge(In, weight);
				In.addOutEdge(e);
				Hn.addInEdge(e);
			}
		}
		
		//Build Edges between hidden and output layers
		for(HiddenNeuron Hn : hiddenNeurons){
			for(OutputNeuron On : outputNeurons){
				float weight = (float)r.nextGaussian();
				Edge e = new Edge(Hn, weight);
				Hn.addOutEdge(e);
				On.addInEdge(e);
			}
		}
	}
	
	
	private static float getResult(float _hoursSlept, float _hoursStudied, 
									float _difficulty){
		inputNeurons.get(0).setData(_hoursSlept);
		inputNeurons.get(1).setData(_hoursStudied);
		inputNeurons.get(2).setData(_difficulty);
		
		//Propegate through
		for(HiddenNeuron Hn : hiddenNeurons){
			ArrayList<Edge> temp = Hn.getInEdges();
			float sumOfEdges = 0;
			for(Edge e : temp){
				sumOfEdges = sumOfEdges + (e.getWeight() * e.getParent().getData());
			}
			//System.out.println(sumOfEdges);
			Hn.setData(sigmoidFunction(sumOfEdges));
			//System.out.println(Hn.getData());
		}
		
		for(OutputNeuron On : outputNeurons){
			ArrayList<Edge> temp = On.getInEdges();
			float sumOfEdges = 0;
			for(Edge e : temp){
				sumOfEdges = sumOfEdges + (e.getWeight() * e.getParent().getData());
			}
			//System.out.println(sumOfEdges);
			 On.setData(sigmoidFunction(sumOfEdges));
		}
		
		return outputNeurons.get(0).getData();		
	}
	
	private static void train(float _hoursSlept,float _hoursStudied, 
							float _difficulty, float expected){
		
		inputNeurons.get(0).setData(_hoursSlept);
		inputNeurons.get(1).setData(_hoursStudied);
		inputNeurons.get(2).setData(_difficulty);
		float actual = 0;
		
		//Propegate through
		for(HiddenNeuron Hn : hiddenNeurons){
			ArrayList<Edge> temp = Hn.getInEdges();
			float sumOfEdges = 0;
			for(Edge e : temp){
				sumOfEdges = sumOfEdges + (e.getWeight() * e.getParent().getData());
			}
			Hn.setSums(sumOfEdges);
			Hn.setData(sigmoidFunction(sumOfEdges));
		}
				
		for(OutputNeuron On : outputNeurons){
			ArrayList<Edge> temp = On.getInEdges();
			float sumOfEdges = 0;
			for(Edge e : temp){
				sumOfEdges = sumOfEdges + (e.getWeight() * e.getParent().getData());
			}
			On.setSums(sumOfEdges);
			On.setData(sigmoidFunction(sumOfEdges));
			actual  = On.getData();
		}
		
		float outputError = actual * (1 - actual) * (actual - expected);
		//System.out.println(outputError);
		
		for(OutputNeuron On : outputNeurons){
			float deltaWeight = 0;
			ArrayList<Edge> temp = On.getInEdges();
			for(Edge e: temp){
				deltaWeight = -learningRate * e.getParent().getData() * outputError;
				e.setDeltaWeight(deltaWeight); 
			}
		}
		
		for(HiddenNeuron Hn : hiddenNeurons){
			float deltaWeight = 0;
			float error = outputError;
			ArrayList<Edge> temp = Hn.getInEdges();
			ArrayList<Edge> temp1 = Hn.getOutEdges();
			for(Edge e: temp){
				float sumOfProprogatedDeltas = 0;
				for(Edge e1 : temp1){
					sumOfProprogatedDeltas += e1.getWeight() * error;
				}
				deltaWeight = -learningRate * e.getParent().getData() * 
								sumOfProprogatedDeltas * Hn.getData() * 
								(1 - Hn.getData());
				e.setDeltaWeight(deltaWeight);
			}
		}
		
		//Changing weights
		for(OutputNeuron On : outputNeurons){
			ArrayList<Edge> temp = On.getInEdges();
			for(Edge e : temp){
				e.setWeight(e.getWeight() + e.getDeltaWeight());
			}
		}
		
		for(HiddenNeuron Hn : hiddenNeurons){
			ArrayList<Edge> temp = Hn.getInEdges();
			for(Edge e : temp){
				e.setWeight(e.getWeight() + e.getDeltaWeight());
			}
		}
	}
	
	
	public static float sigmoidFunction(float x){
		return (float)(1 / (1 + Math.exp(-x)));
	}
	
	public static float sigmoidFunctionPrime(float x){
		return (float)(1 / (1 + Math.exp(-x)) * (1 - 1 / (1 + Math.exp(-x))));
	}
	
	
	public static void printStructure(){
		System.out.println("Input Neurons:");
		for(InputNeuron In : inputNeurons){
			System.out.println(In.getName());
			ArrayList<Edge> temp = In.getOutEdges();
			for(Edge e : temp){
				System.out.println(e.getWeight() + " " + e.getParent());
			}
		}
		for(HiddenNeuron Hn : hiddenNeurons){
			System.out.println("Hidden Neuron:");
			ArrayList<Edge> temp = Hn.getInEdges();
			for(Edge e : temp){
				System.out.println(e.getWeight() + " " + e.getParent());
			}
		}
	}
	
}

