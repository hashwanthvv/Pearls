%%  This algorithm calculates the CPDs of the network using Gene expression data

% Author : Haswanth Vundavilli
% Institution : Texas A&M University
% Email : hashwanthvv@gmail.com

global prob
global G

% The gene(numbers) are connected as shown below
% 1->2; 2->4; 3->4,7; 4->6,10,20,25; 5->6,7; 6->11
% 7->12; 8->9,22; 9->19,20; 10->; 11->8,13,14; 12->15,21,25
% 13->; 14->16; 15->17; 16->18; 17->19; 18->; 19->;
% 20->; 21->10,19; 22->13,20; 23->24; 24->25; 25->10;

%% Following matrix depicts the directed graph of the relevant Biological Network
%    1 2 3 4 5 6 7 8 9 10111213141516171819202122232425
G = [0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 
     0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 
     0 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 
     0 0 0 0 0 1 0 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 1; 
     0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0; 
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0; 
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 
     0 0 0 0 0 0 0 1 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 1;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0; 
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0; 
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0; 
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
     0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;];

%% Phase 1
% Import and store the datasets in your local folder
% Read the excel file
num1 = xlsread('GSE2990_series_matrix.xlsx');

% Find the mean value of all rows
num1_1 = mean(num1,2);

% Initialize the binary matrix
num1_bin = zeros(size(num1,1),size(num1,2));

% Updating the binary matrix
for i = 1:size(num1,1)  
    for j = 1:size(num1,2)
        if num1(i,j) >= num1_1(i)
            num1_bin(i,j) = 1; 
        else
            num1_bin(i,j) = 0;
        end 
    end
end


num2 = xlsread('GSE6532_series_matrix.xlsx');

num2_1 = mean(num2,2);

num2_bin = zeros(size(num2,1),size(num2,2));

for i = 1:size(num2,1)  
    for j = 1:size(num2,2)
        if num2(i,j) >= num2_1(i)
            num2_bin(i,j) = 1; 
        else
            num2_bin(i,j) = 0;
        end 
    end
end


num_bin = cat(2,num1_bin,num2_bin);


 
%% Initializing the probabilities

prob = cell(25,1);
 
%% Looping over all X 


for X = 1:25

        %% Finding the parents of X and storing it in "o"
            o = zeros(size(G,1),1);
                for i = 1:size(G,1)
                        if G(i,X) == 1
                           o(i,1) = i;
                        end
                end
            o = o(any(o,2),:);

        %% Checking for number of parents and sorting accordingly
        if size(o,1) == 0
            %% If no parent

            n_1 = sum(num_bin(X,:) == 1);
            n_0 = sum(num_bin(X,:) == 0);

            prob_A1 = (n_1 + 1) / (n_1 + n_0 + 2);
            prob_A0 = (n_0 + 1) / (n_1 + n_0 + 2);
            
            prob{X} = [prob_A0; prob_A1];

        elseif size(o,1) == 1
            %% If single parent
            n_00 = 0; n_01 = 0; n_10 = 0; n_11 = 0;
            % Finding the parameters
            p = o(1); q = X;

            for i = 1:size(num_bin,2)
                if (num_bin(p,i) == 0) && (num_bin(q,i) == 0)
                    n_00 = n_00 + 1;

                elseif (num_bin(p,i) == 0) && (num_bin(q,i) == 1)
                    n_01 = n_01 + 1;

                elseif (num_bin(p,i) == 1) && (num_bin(q,i) == 0)
                    n_10 = n_10 + 1;

                elseif (num_bin(p,i) == 1) && (num_bin(q,i) == 1)
                    n_11 = n_11 + 1;

                end  
            end

            % Probability of B = 1
            alpha_B1_A1 = n_11 + 1;  beta_B1_A1 = n_10 + 1;
            alpha_B1_A0 = n_01 + 1;  beta_B1_A0 = n_00 + 1;

            prob_B1_A1 = (alpha_B1_A1 / (alpha_B1_A1 + beta_B1_A1));
            prob_B1_A0 = (alpha_B1_A0 / (alpha_B1_A0 + beta_B1_A0));


            % Probability of B = 0
            alpha_B0_A1 = n_10 + 1;  beta_B0_A1 = n_11 + 1;
            alpha_B0_A0 = n_00 + 1;  beta_B0_A0 = n_01 + 1;

            prob_B0_A1 = (alpha_B0_A1 / (alpha_B0_A1 + beta_B0_A1));
            prob_B0_A0 = (alpha_B0_A0 / (alpha_B0_A0 + beta_B0_A0));
            
            prob{X} = [prob_B0_A0, prob_B0_A1; prob_B1_A0, prob_B1_A1];

        elseif size(o,1) == 2
            %% If two parents

            n_000 = 0; n_001 = 0; n_010 = 0; n_011 = 0;
            n_100 = 0; n_101 = 0; n_110 = 0; n_111 = 0;

            x = o(1); y = o(2); z = X;

            for i = 1:size(num_bin,2)
                if (num_bin(x,i) == 0) && (num_bin(y,i) == 0) && (num_bin(z,i) == 0)
                    n_000 = n_000 + 1;

                elseif (num_bin(x,i) == 0) && (num_bin(y,i) == 0) && (num_bin(z,i) == 1)
                    n_001 = n_001 + 1;

                elseif (num_bin(x,i) == 0) && (num_bin(y,i) == 1) && (num_bin(z,i) == 0)
                    n_010 = n_010 + 1;

                elseif (num_bin(x,i) == 0) && (num_bin(y,i) == 1) && (num_bin(z,i) == 1)
                    n_011 = n_011 + 1;

                elseif (num_bin(x,i) == 1) && (num_bin(y,i) == 0) && (num_bin(z,i) == 0)
                    n_100 = n_100 + 1;

                elseif (num_bin(x,i) == 1) && (num_bin(y,i) == 0) && (num_bin(z,i) == 1)
                    n_101 = n_101 + 1;

                elseif (num_bin(x,i) == 1) && (num_bin(y,i) == 1) && (num_bin(z,i) == 0)
                    n_110 = n_110 + 1;

                elseif (num_bin(x,i) == 1) && (num_bin(y,i) == 1) && (num_bin(z,i) == 1)
                    n_111 = n_111 + 1;
                end  
            end

            % Probability of Z = 1 
            alpha_Z1_X1_Y1 = n_111 + 1; beta_Z1_X1_Y1 = n_110 + 1;
            alpha_Z1_X0_Y1 = n_011 + 1; beta_Z1_X0_Y1 = n_010 + 1; 
            alpha_Z1_X0_Y0 = n_001 + 1; beta_Z1_X0_Y0 = n_000 + 1; 
            alpha_Z1_X1_Y0 = n_101 + 1; beta_Z1_X1_Y0 = n_100 + 1;


            prob_Z1_X1_Y1 = (alpha_Z1_X1_Y1 / (alpha_Z1_X1_Y1 + beta_Z1_X1_Y1));
            prob_Z1_X0_Y0 = (alpha_Z1_X0_Y0 / (alpha_Z1_X0_Y0 + beta_Z1_X0_Y0));
            prob_Z1_X0_Y1 = (alpha_Z1_X0_Y1 / (alpha_Z1_X0_Y1 + beta_Z1_X0_Y1));
            prob_Z1_X1_Y0 = (alpha_Z1_X1_Y0 / (alpha_Z1_X1_Y0 + beta_Z1_X1_Y0));


            % Probability of Z = 0 
            alpha_Z0_X1_Y1 = n_110 + 1; beta_Z0_X1_Y1 = n_111 + 1;
            alpha_Z0_X0_Y1 = n_010 + 1; beta_Z0_X0_Y1 = n_011 + 1;
            alpha_Z0_X0_Y0 = n_000 + 1; beta_Z0_X0_Y0 = n_001 + 1; 
            alpha_Z0_X1_Y0 = n_100 + 1; beta_Z0_X1_Y0 = n_101 + 1;


            prob_Z0_X1_Y1 = (alpha_Z0_X1_Y1 / (alpha_Z0_X1_Y1 + beta_Z0_X1_Y1));
            prob_Z0_X0_Y0 = (alpha_Z0_X0_Y0 / (alpha_Z0_X0_Y0 + beta_Z0_X0_Y0));
            prob_Z0_X0_Y1 = (alpha_Z0_X0_Y1 / (alpha_Z0_X0_Y1 + beta_Z0_X0_Y1));
            prob_Z0_X1_Y0 = (alpha_Z0_X1_Y0 / (alpha_Z0_X1_Y0 + beta_Z0_X1_Y0));


            prob{X} = [prob_Z0_X0_Y0, prob_Z0_X0_Y1, prob_Z0_X1_Y0, prob_Z0_X1_Y1; prob_Z1_X0_Y0, prob_Z1_X0_Y1, prob_Z1_X1_Y0, prob_Z1_X1_Y1];

            
            elseif size(o,1) == 3
            %% If three parents

            n_0000 = 0; n_0001 = 0; n_0010 = 0; n_0011 = 0; n_0100 = 0; n_0101 = 0; n_0110 = 0; n_0111 = 0;
            n_1000 = 0; n_1001 = 0; n_1010 = 0; n_1011 = 0; n_1100 = 0; n_1101 = 0; n_1110 = 0; n_1111 = 0;

            x = o(1); y = o(2); z = o(3); g = X;

            for i = 1:size(num_bin,2)
                if (num_bin(x,i) == 0) && (num_bin(y,i) == 0) && (num_bin(z,i) == 0) && (num_bin(g,i) == 0)
                    n_0000 = n_0000 + 1;

                elseif (num_bin(x,i) == 0) && (num_bin(y,i) == 0) && (num_bin(z,i) == 1) && (num_bin(g,i) == 0)
                    n_0010 = n_0010 + 1;

                elseif (num_bin(x,i) == 0) && (num_bin(y,i) == 1) && (num_bin(z,i) == 0) && (num_bin(g,i) == 0)
                    n_0100 = n_0100 + 1;

                elseif (num_bin(x,i) == 0) && (num_bin(y,i) == 1) && (num_bin(z,i) == 1) && (num_bin(g,i) == 0)
                    n_0110 = n_0110 + 1; 

                elseif (num_bin(x,i) == 1) && (num_bin(y,i) == 0) && (num_bin(z,i) == 0) && (num_bin(g,i) == 0)
                    n_0100 = n_0100 + 1;

                elseif (num_bin(x,i) == 1) && (num_bin(y,i) == 0) && (num_bin(z,i) == 1) && (num_bin(g,i) == 0)
                    n_1010 = n_1010 + 1;

                elseif (num_bin(x,i) == 1) && (num_bin(y,i) == 1) && (num_bin(z,i) == 0) && (num_bin(g,i) == 0)
                    n_1100 = n_1100 + 1;

                elseif (num_bin(x,i) == 1) && (num_bin(y,i) == 1) && (num_bin(z,i) == 1) && (num_bin(g,i) == 0)
                    n_1110 = n_1110 + 1;
          
                elseif (num_bin(x,i) == 0) && (num_bin(y,i) == 0) && (num_bin(z,i) == 0) && (num_bin(g,i) == 1)
                    n_0001 = n_0001 + 1;

                elseif (num_bin(x,i) == 0) && (num_bin(y,i) == 0) && (num_bin(z,i) == 1) && (num_bin(g,i) == 1)
                    n_0011 = n_0011 + 1;

                elseif (num_bin(x,i) == 0) && (num_bin(y,i) == 1) && (num_bin(z,i) == 0) && (num_bin(g,i) == 1)
                    n_0101 = n_0101 + 1;

                elseif (num_bin(x,i) == 0) && (num_bin(y,i) == 1) && (num_bin(z,i) == 1) && (num_bin(g,i) == 1)
                    n_0111 = n_0111 + 1; 

                elseif (num_bin(x,i) == 1) && (num_bin(y,i) == 0) && (num_bin(z,i) == 0) && (num_bin(g,i) == 1)
                    n_1001 = n_1001 + 1;

                elseif (num_bin(x,i) == 1) && (num_bin(y,i) == 0) && (num_bin(z,i) == 1) && (num_bin(g,i) == 1)
                    n_1011 = n_1011 + 1;

                elseif (num_bin(x,i) == 1) && (num_bin(y,i) == 1) && (num_bin(z,i) == 0) && (num_bin(g,i) == 1)
                    n_1101 = n_1101 + 1;

                elseif (num_bin(x,i) == 1) && (num_bin(y,i) == 1) && (num_bin(z,i) == 1) && (num_bin(g,i) == 1)
                    n_1111 = n_1111 + 1;
                end 
            end

            % Probability of g = 1 
            
            alpha_G1_X1_Y1_Z1 = n_1111 + 1; beta_G1_X1_Y1_Z1 = n_1110 + 1;
            alpha_G1_X1_Y1_Z0 = n_1101 + 1; beta_G1_X1_Y1_Z0 = n_1100 + 1; 
            alpha_G1_X1_Y0_Z1 = n_1011 + 1; beta_G1_X1_Y0_Z1 = n_1010 + 1; 
            alpha_G1_X1_Y0_Z0 = n_1001 + 1; beta_G1_X1_Y0_Z0 = n_1000 + 1;
            alpha_G1_X0_Y1_Z1 = n_0111 + 1; beta_G1_X0_Y1_Z1 = n_0110 + 1;
            alpha_G1_X0_Y1_Z0 = n_0101 + 1; beta_G1_X0_Y1_Z0 = n_0100 + 1; 
            alpha_G1_X0_Y0_Z1 = n_0011 + 1; beta_G1_X0_Y0_Z1 = n_0010 + 1;
            alpha_G1_X0_Y0_Z0 = n_0001 + 1; beta_G1_X0_Y0_Z0 = n_0000 + 1; 

            prob_G1_X1_Y1_Z1 = (alpha_G1_X1_Y1_Z1 / (alpha_G1_X1_Y1_Z1 + beta_G1_X1_Y1_Z1));
            prob_G1_X1_Y1_Z0 = (alpha_G1_X1_Y1_Z0 / (alpha_G1_X1_Y1_Z0 + beta_G1_X1_Y1_Z0));
            prob_G1_X1_Y0_Z1 = (alpha_G1_X1_Y0_Z1 / (alpha_G1_X1_Y0_Z1 + beta_G1_X1_Y0_Z1));
            prob_G1_X1_Y0_Z0 = (alpha_G1_X1_Y0_Z0 / (alpha_G1_X1_Y0_Z0 + beta_G1_X1_Y0_Z0));
            prob_G1_X0_Y1_Z1 = (alpha_G1_X0_Y1_Z1 / (alpha_G1_X0_Y1_Z1 + beta_G1_X0_Y1_Z1));
            prob_G1_X0_Y1_Z0 = (alpha_G1_X0_Y1_Z0 / (alpha_G1_X0_Y1_Z0 + beta_G1_X0_Y1_Z0));
            prob_G1_X0_Y0_Z1 = (alpha_G1_X0_Y0_Z1 / (alpha_G1_X0_Y0_Z1 + beta_G1_X0_Y0_Z1));
            prob_G1_X0_Y0_Z0 = (alpha_G1_X0_Y0_Z0 / (alpha_G1_X0_Y0_Z0 + beta_G1_X0_Y0_Z0));


            % Probability of Z = 0 
            prob_G0_X1_Y1_Z1 = 1 - prob_G1_X1_Y1_Z1;
            prob_G0_X1_Y1_Z0 = 1 - prob_G1_X1_Y1_Z0;
            prob_G0_X1_Y0_Z1 = 1 - prob_G1_X1_Y0_Z1;
            prob_G0_X1_Y0_Z0 = 1 - prob_G1_X1_Y0_Z0;
            prob_G0_X0_Y1_Z1 = 1 - prob_G1_X0_Y1_Z1;
            prob_G0_X0_Y1_Z0 = 1 - prob_G1_X0_Y1_Z0;
            prob_G0_X0_Y0_Z1 = 1 - prob_G1_X0_Y0_Z1;
            prob_G0_X0_Y0_Z0 = 1 - prob_G1_X0_Y0_Z0;

            prob{X} = [prob_G0_X0_Y0_Z0, prob_G0_X0_Y0_Z1, prob_G0_X0_Y1_Z0, prob_G0_X0_Y1_Z1, prob_G0_X1_Y0_Z0, prob_G0_X1_Y0_Z1, prob_G0_X1_Y1_Z0, prob_G0_X1_Y1_Z1; prob_G1_X0_Y0_Z0, prob_G1_X0_Y0_Z1, prob_G1_X0_Y1_Z0, prob_G1_X0_Y1_Z1, prob_G1_X1_Y0_Z0, prob_G1_X1_Y0_Z1, prob_G1_X1_Y1_Z0, prob_G1_X1_Y1_Z1];

        end

end



fprintf('The conditional probability that gene CRLF2 is expressed is: %f \n',prob{1}(2));
fprintf('The conditional probability that gene JAK2 is expressed is: %f \n',prob{2}(2,:));
fprintf('The conditional probability that gene MUC1 is expressed is: %f \n',prob{3}(2,:));
fprintf('The conditional probability that gene STAT3 is expressed is: %f \n',prob{4}(2,:));
fprintf('The conditional probability that gene RAS is expressed is: %f \n',prob{5}(2,:));
fprintf('The conditional probability that gene PIK3CA is expressed is: %f \n',prob{6}(2,:));
fprintf('The conditional probability that gene RAF1 is expressed is: %f \n',prob{7}(2,:));
fprintf('The conditional probability that gene mTOR is expressed is: %f \n',prob{8}(2,:));
fprintf('The conditional probability that gene eIF4E is expressed is: %f \n',prob{9}(2,:));
fprintf('The conditional probability that gene BCL-2 is expressed is: %f \n',prob{10}(2,:));
fprintf('The conditional probability that gene Akt is expressed is: %f \n',prob{11}(2,:));
fprintf('The conditional probability that gene MEK is expressed is: %f \n',prob{12}(2,:));
prob{13}([1,2],:) = prob{13}([2,1],:); % To account for the inhibition in genes
fprintf('The conditional probability that gene BAD is expressed is: %f \n',prob{13}(2,:));
fprintf('The conditional probability that gene NFKB is expressed is: %f \n',prob{14}(2,:));
fprintf('The conditional probability that gene MAPK1 is expressed is: %f \n',prob{15}(2,:));
fprintf('The conditional probability that gene PGP is expressed is: %f \n',prob{16}(2,:));
fprintf('The conditional probability that gene FOS is expressed is: %f \n',prob{17}(2,:));
prob{18}([1,2],:) = prob{18}([2,1],:); % To account for the inhibition in genes
fprintf('The conditional probability that gene CERK is expressed is: %f \n',prob{18}(2,:));
fprintf('The conditional probability that gene MCL1 is expressed is: %f \n',prob{19}(2,:));
fprintf('The conditional probability that gene BIRC5 is expressed is: %f \n',prob{20}(2,:));
fprintf('The conditional probability that gene JUN is expressed is: %f \n',prob{21}(2,:));
fprintf('The conditional probability that gene RPS6KB1 is expressed is: %f \n',prob{22}(2,:));
fprintf('The conditional probability that gene ERBB2 is expressed is: %f \n',prob{23}(2,:));
fprintf('The conditional probability that gene SRC is expressed is: %f \n',prob{24}(2,:));
fprintf('The conditional probability that gene MYC is expressed is: %f \n',prob{25}(2,:));




