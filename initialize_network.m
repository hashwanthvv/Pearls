% Author : Haswanth Vundavilli
% Institution : Texas A&M University
% Email : hashwanthvv@gmail.com


%% Globalizing all the variables to be used in the different functions
global G
global E
global e
global prob
global pi_Y
global lambda
global pi
global lambda_X
global cond_prob
global p_tilda

%% Initializing the G matrix


% Initializing E, e, lambda, pi values
E = []; 
e = [];
pi = zeros(size(G,1),2);
lambda = zeros(size(G,1),2);



%% Initializing Lambda messages - {From , To}
lambda_X = cell(26,26);
lambda_X{2,1} = [0; 0];
lambda_X{4,2} = [0; 0];
lambda_X{4,3} = [0; 0];
lambda_X{6,4} = [0; 0];
lambda_X{6,5} = [0; 0];
lambda_X{7,5} = [0; 0];
lambda_X{8,11} = [0; 0];
lambda_X{9,8} = [0; 0];
lambda_X{10,4} = [0; 0];
lambda_X{10,22} = [0; 0];
lambda_X{10,26} = [0; 0];
lambda_X{11,6} = [0; 0];
lambda_X{12,2} = [0; 0];
lambda_X{12,7} = [0; 0];
lambda_X{13,11} = [0; 0];
lambda_X{13,23} = [0; 0];
lambda_X{14,11} = [0; 0];
lambda_X{15,12} = [0; 0];
lambda_X{16,14} = [0; 0];
lambda_X{17,15} = [0; 0];
lambda_X{18,16} = [0; 0];
lambda_X{19,9} = [0; 0];
lambda_X{19,17} = [0; 0];
lambda_X{19,22} = [0; 0];
lambda_X{20,4} = [0; 0];
lambda_X{20,9} = [0; 0];
lambda_X{20,23} = [0; 0];
lambda_X{22,12} = [0; 0];
lambda_X{23,8} = [0; 0];
lambda_X{25,24} = [0; 0];
lambda_X{26,4} = [0; 0];
lambda_X{26,25} = [0; 0];


 
%% Initializing Pi messages - {From , To}
pi_Y = cell(26,26);
pi_Y{1,2} = [0; 0];
pi_Y{2,4} = [0; 0];
pi_Y{2,12} = [0; 0];
pi_Y{3,4} = [0; 0];
pi_Y{4,6} = [0; 0];
pi_Y{4,10} = [0; 0];
pi_Y{4,20} = [0; 0];
pi_Y{4,26} = [0; 0];
pi_Y{5,6} = [0; 0];
pi_Y{5,7} = [0; 0];
pi_Y{6,11} = [0; 0];
pi_Y{7,12} = [0; 0];
pi_Y{8,9} = [0; 0];
pi_Y{8,23} = [0; 0];
pi_Y{9,19} = [0; 0];
pi_Y{9,20} = [0; 0];
pi_Y{11,8} = [0; 0];
pi_Y{11,13} = [0; 0];
pi_Y{11,14} = [0; 0];
pi_Y{12,15} = [0; 0];
pi_Y{12,22} = [0; 0];
pi_Y{14,16} = [0; 0];
pi_Y{15,17} = [0; 0];
pi_Y{16,18} = [0; 0];
pi_Y{17,19} = [0; 0];
pi_Y{22,10} = [0; 0];
pi_Y{22,19} = [0; 0];
pi_Y{23,13} = [0; 0];
pi_Y{23,20} = [0; 0];
pi_Y{24,25} = [0; 0];
pi_Y{25,26} = [0; 0];
pi_Y{26,10} = [0; 0];


%% Initializing the Conditional Probabilities which are to be computed
cond_prob = cell(26,1); 
cond_prob{1} = [0;0];
cond_prob{2} = [0;0];
cond_prob{3} = [0;0];
cond_prob{4} = [0;0];
cond_prob{5} = [0;0];
cond_prob{6} = [0;0];
cond_prob{7} = [0;0];
cond_prob{8} = [0;0];
cond_prob{9} = [0;0];
cond_prob{10} = [0;0];
cond_prob{11} = [0;0];
cond_prob{12} = [0;0];
cond_prob{13} = [0;0];
cond_prob{14} = [0;0];
cond_prob{15} = [0;0];
cond_prob{16} = [0;0];
cond_prob{17} = [0;0];
cond_prob{18} = [0;0];
cond_prob{19} = [0;0];
cond_prob{20} = [0;0];
cond_prob{21} = [0;0];
cond_prob{22} = [0;0];
cond_prob{23} = [0;0];
cond_prob{24} = [0;0];
cond_prob{25} = [0;0];

%% Initializing the P-tilda
p_tilda = cell(26,1);
p_tilda{1} = [0;0];
p_tilda{2} = [0;0];
p_tilda{3} = [0;0];
p_tilda{4} = [0;0];
p_tilda{5} = [0;0];
p_tilda{6} = [0;0];
p_tilda{7} = [0;0];
p_tilda{8} = [0;0];
p_tilda{9} = [0;0];
p_tilda{10} = [0;0];
p_tilda{11} = [0;0];
p_tilda{12} = [0;0];
p_tilda{13} = [0;0];
p_tilda{14} = [0;0];
p_tilda{15} = [0;0];
p_tilda{16} = [0;0];
p_tilda{17} = [0;0];
p_tilda{18} = [0;0];
p_tilda{19} = [0;0];
p_tilda{20} = [0;0];
p_tilda{21} = [0;0];
p_tilda{22} = [0;0];
p_tilda{23} = [0;0];
p_tilda{24} = [0;0];
p_tilda{25} = [0;0];


%% Looping over all the random variables for initialization
for i = 1:size(G,1)
    
    % Initializing all the lambda values equal to 1
    lambda(i,1) = 1;  % For x = 0
    lambda(i,2) = 1;  % For x = 1

    for j = 1:size(G,1)
        % For the parents of X, lambda_X = 1,  j(parent) <--- i(child)
            if G(j,i) == 1
                  lambda_X{i,j}(1,1) = 1;
                  lambda_X{i,j}(2,1) = 1;
            end
        % For the children of X, pi_Y = 1,  i(parent) ---> j(child)
            if G(i,j) == 1
                  pi_Y{i,j}(1,1) = 1;
                  pi_Y{i,j}(2,1) = 1;
            end
    end

end


%% Finding the Root nodes 
    % Defining the root nodes
    R = zeros(size(G,1),1);

    % Finding the sum of column vectors to check for root nodes
    S = sum(G);

    % Checking if zero, then its a root node
    for i = 1:size(G,1)
        if S(i) == 0
            R(i) = i;
        end
    end

    % Removing the zeros and declaring our roots
    R = R(any(R,2),:);


%% Looping over the Root nodes and setting the pi value = Prob
for s = 1:size(R,1)

    pi(R(s),1) = prob{R(s)}(1,1);
    pi(R(s),2) = prob{R(s)}(2,1);
    
    cond_prob{R(s)}(1,1) = prob{R(s)}(1,1);
    cond_prob{R(s)}(2,1) = prob{R(s)}(2,1);
    
    %% Looping over the children of R, send pi message R(s) ---> W(Child)
    for W = 1:size(G,1)
        if G(R(s),W) == 1
            send_pi_message(R(s),W);
        end
    end
    
end


%% Update network called as per evidence    
% Modify the gene_number and gene_status accordingly

gene_number = 4; % Gene numbered 4 is in the evidence set
gene_status = 1; % The status 1 corresponds to the gene being OFF, and 2 for ON
update_network(gene_number,gene_status); % Comment or modify the parameters to call a new evidence

fprintf('\n');
if gene_status == 1
   fprintf('The gene numbered %d is OFF\n',gene_number);
elseif gene_status == 2
   fprintf('The gene numbered %d is ON\n',gene_number);
end

gene_number1 = 6; % Gene numbered 6 is in the evidence set
gene_status1 = 1; % The status 1 corresponds to the gene being OFF, and 2 for ON
update_network(gene_number1,gene_status1); % Comment or modify the parameters to call a new evidence
fprintf('\n');
if gene_status1 == 1
   fprintf('The gene numbered %d is OFF\n',gene_number1);
elseif gene_status1 == 2
   fprintf('The gene numbered %d is ON\n',gene_number1);
end

 fprintf('\n');
 fprintf('BCL-2 = 0 : %f \n',cond_prob{10}(1));
 fprintf('Survivin = 0 : %f \n',cond_prob{20}(1));
 fprintf('MCL1 = 0 : %f \n',cond_prob{19}(1));
 fprintf('CERK = 1 : %f \n',cond_prob{18}(2));
 fprintf('BAD = 1 : %f \n',cond_prob{13}(2));

fprintf('\n');
fprintf('Apoptosis Ratio = %f \n',((cond_prob{13}(2)+cond_prob{18}(2))./(cond_prob{10}(2)+cond_prob{20}(2)+cond_prob{19}(2))));

fprintf('\n');