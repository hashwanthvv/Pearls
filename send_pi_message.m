function [] = send_pi_message(Z,X)

    %% Globalizing our variables
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
   
     
    %% Finding the children of Z and storing it in "n"
    n = zeros(size(G,1),1);
        for i = 1:size(G,1)
                if G(Z,i) == 1
                    n(i,1) = i;
                end
        end
    n = n(any(n,2),:);
    
    %% Checking the number of children and looping as needed
    % If just a single child pass the pi message Z ---> X directly
    if size(n,1) == 1  
        pi_Y{Z,X}(1,1) = pi(Z,1);
        pi_Y{Z,X}(2,1) = pi(Z,2);
    
    % If two children of Z then we have two cases
    elseif size(n,1) == 2
        % If n(1) is X then for using lambda message send n(2) ---> Z
        if n(1) == X
            pi_Y{Z,X}(1) = pi(Z,1)*lambda_X{n(2),Z}(1);
            pi_Y{Z,X}(2) = pi(Z,2)*lambda_X{n(2),Z}(2);
        % Else evaluate pi message using lambda message n(1) ---> Z
        else 
            pi_Y{Z,X}(1,1) = pi(Z,1)*lambda_X{n(1),Z}(1);
            pi_Y{Z,X}(2,1) = pi(Z,2)*lambda_X{n(1),Z}(2);
        end
    
     % If three children of Z then we have three cases    
    elseif size(n,1) == 3
        if n(1) == X
            pi_Y{Z,X}(1) = pi(Z,1)*lambda_X{n(2),Z}(1)*lambda_X{n(3),Z}(1);
            pi_Y{Z,X}(2) = pi(Z,2)*lambda_X{n(2),Z}(2)*lambda_X{n(3),Z}(2);
        elseif n(2) == X 
            pi_Y{Z,X}(1,1) = pi(Z,1)*lambda_X{n(1),Z}(1)*lambda_X{n(3),Z}(1);
            pi_Y{Z,X}(2,1) = pi(Z,2)*lambda_X{n(1),Z}(2)*lambda_X{n(3),Z}(2);
        elseif n(3) == X 
            pi_Y{Z,X}(1,1) = pi(Z,1)*lambda_X{n(1),Z}(1)*lambda_X{n(2),Z}(1);
            pi_Y{Z,X}(2,1) = pi(Z,2)*lambda_X{n(1),Z}(2)*lambda_X{n(2),Z}(2);
        end
     
      % If four children of Z then we have four cases   
    elseif size(n,1) == 4
        if n(1) == X
            pi_Y{Z,X}(1) = pi(Z,1)*lambda_X{n(2),Z}(1)*lambda_X{n(3),Z}(1)*lambda_X{n(4),Z}(1);
            pi_Y{Z,X}(2) = pi(Z,2)*lambda_X{n(2),Z}(2)*lambda_X{n(3),Z}(2)*lambda_X{n(4),Z}(2);
        elseif n(2) == X 
            pi_Y{Z,X}(1,1) = pi(Z,1)*lambda_X{n(1),Z}(1)*lambda_X{n(3),Z}(1)*lambda_X{n(4),Z}(1);
            pi_Y{Z,X}(2,1) = pi(Z,2)*lambda_X{n(1),Z}(2)*lambda_X{n(3),Z}(2)*lambda_X{n(4),Z}(2);
        elseif n(3) == X 
            pi_Y{Z,X}(1,1) = pi(Z,1)*lambda_X{n(1),Z}(1)*lambda_X{n(2),Z}(1)*lambda_X{n(4),Z}(1);
            pi_Y{Z,X}(2,1) = pi(Z,2)*lambda_X{n(1),Z}(2)*lambda_X{n(2),Z}(2)*lambda_X{n(4),Z}(2);
        elseif n(4) == X 
            pi_Y{Z,X}(1,1) = pi(Z,1)*lambda_X{n(1),Z}(1)*lambda_X{n(2),Z}(1)*lambda_X{n(3),Z}(1);
            pi_Y{Z,X}(2,1) = pi(Z,2)*lambda_X{n(1),Z}(2)*lambda_X{n(2),Z}(2)*lambda_X{n(3),Z}(2);
        end
     
      % If five children of Z then we have five cases  
    elseif size(n,1) == 5
        if n(1) == X
            pi_Y{Z,X}(1) = pi(Z,1)*lambda_X{n(2),Z}(1)*lambda_X{n(3),Z}(1)*lambda_X{n(4),Z}(1)*lambda_X{n(5),Z}(1);
            pi_Y{Z,X}(2) = pi(Z,2)*lambda_X{n(2),Z}(2)*lambda_X{n(3),Z}(2)*lambda_X{n(4),Z}(2)*lambda_X{n(5),Z}(2);
        elseif n(2) == X 
            pi_Y{Z,X}(1,1) = pi(Z,1)*lambda_X{n(1),Z}(1)*lambda_X{n(3),Z}(1)*lambda_X{n(4),Z}(1)*lambda_X{n(5),Z}(1);
            pi_Y{Z,X}(2,1) = pi(Z,2)*lambda_X{n(1),Z}(2)*lambda_X{n(3),Z}(2)*lambda_X{n(4),Z}(2)*lambda_X{n(5),Z}(2);
        elseif n(3) == X 
            pi_Y{Z,X}(1,1) = pi(Z,1)*lambda_X{n(1),Z}(1)*lambda_X{n(2),Z}(1)*lambda_X{n(4),Z}(1)*lambda_X{n(5),Z}(1);
            pi_Y{Z,X}(2,1) = pi(Z,2)*lambda_X{n(1),Z}(2)*lambda_X{n(2),Z}(2)*lambda_X{n(4),Z}(2)*lambda_X{n(5),Z}(2);
        elseif n(4) == X 
            pi_Y{Z,X}(1,1) = pi(Z,1)*lambda_X{n(1),Z}(1)*lambda_X{n(2),Z}(1)*lambda_X{n(3),Z}(1)*lambda_X{n(5),Z}(1);
            pi_Y{Z,X}(2,1) = pi(Z,2)*lambda_X{n(1),Z}(2)*lambda_X{n(2),Z}(2)*lambda_X{n(3),Z}(2)*lambda_X{n(5),Z}(2);
        elseif n(5) == X 
            pi_Y{Z,X}(1,1) = pi(Z,1)*lambda_X{n(1),Z}(1)*lambda_X{n(2),Z}(1)*lambda_X{n(3),Z}(1)*lambda_X{n(4),Z}(1);
            pi_Y{Z,X}(2,1) = pi(Z,2)*lambda_X{n(1),Z}(2)*lambda_X{n(2),Z}(2)*lambda_X{n(3),Z}(2)*lambda_X{n(4),Z}(2);
        end
    end
    
    %% Finding the parents of X and storing it in "o"
    o = zeros(size(G,1),1);
        for i = 1:size(G,1)
                if G(i,X) == 1
                   o(i,1) = i;
                end
        end
    o = o(any(o,2),:);
    
    %% Checking if X belongs to the evidence set E, and computing the Pi value of X
    if ismember(X,E) == 0
        
        % If single parent of X, send pi message Z = o(1) ---> X
        if size(o,1) == 1
            pi(X,1) = prob{X}(1,1)*pi_Y{Z,X}(1,1) + prob{X}(1,2)*pi_Y{Z,X}(2,1);
            pi(X,2) = prob{X}(2,1)*pi_Y{Z,X}(1,1) + prob{X}(2,2)*pi_Y{Z,X}(2,1);
        
        % If two parents of X, send pi messages o(1) ---> X, o(2) ---> X   
        elseif size(o,1) == 2
            pi(X,1) = prob{X}(1,1)*pi_Y{o(1),X}(1,1)*pi_Y{o(2),X}(1,1) + prob{X}(1,2)*pi_Y{o(1),X}(1,1)*pi_Y{o(2),X}(2,1) + prob{X}(1,3)*pi_Y{o(1),X}(2,1)*pi_Y{o(2),X}(1,1) + prob{X}(1,4)*pi_Y{o(1),X}(2,1)*pi_Y{o(2),X}(2,1);
            pi(X,2) = prob{X}(2,1)*pi_Y{o(1),X}(1,1)*pi_Y{o(2),X}(1,1) + prob{X}(2,2)*pi_Y{o(1),X}(1,1)*pi_Y{o(2),X}(2,1) + prob{X}(2,3)*pi_Y{o(1),X}(2,1)*pi_Y{o(2),X}(1,1) + prob{X}(2,4)*pi_Y{o(1),X}(2,1)*pi_Y{o(2),X}(2,1);
            
        % If three parents of X, send pi messages o(1) ---> X, o(2) ---> X, o(3) ---> X  
        elseif size(o,1) == 3
            pi(X,1) = prob{X}(1,1)*pi_Y{o(1),X}(1,1)*pi_Y{o(2),X}(1,1)*pi_Y{o(3),X}(1,1) + prob{X}(1,2)*pi_Y{o(1),X}(1,1)*pi_Y{o(2),X}(1,1)*pi_Y{o(3),X}(2,1) + prob{X}(1,3)*pi_Y{o(1),X}(1,1)*pi_Y{o(2),X}(2,1)*pi_Y{o(3),X}(1,1) + prob{X}(1,4)*pi_Y{o(1),X}(1,1)*pi_Y{o(2),X}(2,1)*pi_Y{o(3),X}(2,1) + prob{X}(1,5)*pi_Y{o(1),X}(2,1)*pi_Y{o(2),X}(1,1)*pi_Y{o(3),X}(1,1) + prob{X}(1,6)*pi_Y{o(1),X}(2,1)*pi_Y{o(2),X}(1,1)*pi_Y{o(3),X}(2,1) + prob{X}(1,7)*pi_Y{o(1),X}(2,1)*pi_Y{o(2),X}(2,1)*pi_Y{o(3),X}(1,1) + prob{X}(1,8)*pi_Y{o(1),X}(2,1)*pi_Y{o(2),X}(2,1)*pi_Y{o(3),X}(2,1);
            pi(X,2) = prob{X}(2,1)*pi_Y{o(1),X}(1,1)*pi_Y{o(2),X}(1,1)*pi_Y{o(3),X}(1,1) + prob{X}(2,2)*pi_Y{o(1),X}(1,1)*pi_Y{o(2),X}(1,1)*pi_Y{o(3),X}(2,1) + prob{X}(2,3)*pi_Y{o(1),X}(1,1)*pi_Y{o(2),X}(2,1)*pi_Y{o(3),X}(1,1) + prob{X}(2,4)*pi_Y{o(1),X}(1,1)*pi_Y{o(2),X}(2,1)*pi_Y{o(3),X}(2,1) + prob{X}(2,5)*pi_Y{o(1),X}(2,1)*pi_Y{o(2),X}(1,1)*pi_Y{o(3),X}(1,1) + prob{X}(2,6)*pi_Y{o(1),X}(2,1)*pi_Y{o(2),X}(1,1)*pi_Y{o(3),X}(2,1) + prob{X}(2,7)*pi_Y{o(1),X}(2,1)*pi_Y{o(2),X}(2,1)*pi_Y{o(3),X}(1,1) + prob{X}(2,8)*pi_Y{o(1),X}(2,1)*pi_Y{o(2),X}(2,1)*pi_Y{o(3),X}(2,1);    
        end
        
        % Finding the P-tilda for values of X=0, X=1
        p_tilda{X}(1,1) = lambda(X,1)*pi(X,1);
        p_tilda{X}(2,1) = lambda(X,2)*pi(X,2);
        
        % Normalizing the probabilities and finding Conditional Prob
        cond_prob{X}(1,1) = p_tilda{X}(1,1)/(p_tilda{X}(1,1) + p_tilda{X}(2,1));
        cond_prob{X}(2,1) = p_tilda{X}(2,1)/(p_tilda{X}(1,1) + p_tilda{X}(2,1));

        % Finding the children of X and storing in p
        p = zeros(size(G,1),1);
        for j = 1:size(G,1)
                if G(X,j) == 1
                    p(j,1) = j;
                end
        end
        p = p(any(p,2),:);        
        
        %% Sending the Pi messages from X to its children X ---> p
        if size(p,1) ~= 0
            for k = 1:size(p,1)
                send_pi_message(X,p(k));
            end
        end
        
    end
    
    
    %% Checking if any lambda value is not equal to unity
    if (lambda(X,1) ~= 1) || (lambda(X,2) ~= 1)
        % Using "o"(parents of X)
        % If two parents send lambda message from X ---> Other Parent (X)       
        if size(o,1) == 2
            % If o(1) has Z, send lambda message X --> o(2)[not in evidence]
            if (o(1) == Z) && ( ~ismember(o(2),E) )
                send_lambda_message(X,o(2));
            % Else If o(2) has Z, send lambda message from X ---> o(1)    
            elseif (o(2) == Z) && ( ~ismember(o(1),E) )
                send_lambda_message(X,o(1));        
            end        
        end
        
        if size(o,1) == 3
            % If o(1) has Z, send lambda message X --> o(2)and X --> o(3)[not in evidence]
            if (o(1) == Z) 
                if ( ~ismember(o(2),E) )
                  send_lambda_message(X,o(2));
                end
                if ( ~ismember(o(3),E) )
                    send_lambda_message(X,o(3));
                end
            % Else If o(2) has Z, send lambda message from X ---> o(1)  and X ---> o(3) 
            elseif (o(2) == Z) 
                if ( ~ismember(o(1),E) )
                  send_lambda_message(X,o(1));
                end
                if ( ~ismember(o(3),E) )
                    send_lambda_message(X,o(3));
                end
            % Else If o(3) has Z, send lambda message from X ---> o(1)  and X ---> o(2) 
            elseif (o(3) == Z) 
                if ( ~ismember(o(1),E) )
                  send_lambda_message(X,o(1));
                end
                if ( ~ismember(o(2),E) )
                    send_lambda_message(X,o(2));
                end    
            end        
        end
            
    end

 end