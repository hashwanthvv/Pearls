#Pearl's Algorithm on Breast Cancer

This repository contains the MATLAB codes to implement the Belief Propagation algorithm on the Breast Cancer Pathway.

The script calculating_probabilities.m calculates the conditional probabilities of all nodes with the input graph structure and gene expression data set. The script initialize_network.m initializes the network where we define variables and set their values. We start to send the pi-messages from the root nodes and eventually send them from all the parents to their children. These pi-messages help us in calculating the probabilities of nodes.

After all the pi-messages are sent, we update the network with evidence by calling update_network. The update_network takes the appropriate parameters of the evidence and send the lambda-messages from child to parents using send_lambda_message.

These lambda-messages sent are needed to find the updated probabilities of the nodes given the evidence. We then send the pi-messages from the evidence to its children to update their conditional probabilities.

How to run the code: The code is implemented in Matlab. Open all the four Matlab files enclosed in the folder. Run calculating_probabilities.m to calculate the conditional probabilities of all nodes. To modify the graph structure, please modify the G matrix defined in the calculating_probabilities. Run initialize_network.m to initiate the exchange of pi-messages and lambda-messages. To change the evidence, modify the input arguments in lines 224 and 235 as required.
