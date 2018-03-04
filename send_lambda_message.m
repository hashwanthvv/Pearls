function [] = send_lambda_message(Y,X)
    
    %% Globalizing our variables
    global G
    global E
    global e
    global prob
    global pi_Y
    global lambda
    global pi
    global lambda_X
    global p_tilda
    global cond_prob
     
   %% Finding the parents of Y and storing in "k"
    k = zeros(size(G,1),1); 
        for i = 1:size(G,1)
                if G(i,Y) == 1
                   k(i,1) = i;
                end
        end
    k = k(any(k,2),:);   
    
 
    %% Sending the Lambda Message Y ---> X(parent)
        % If single parent, simply send lambda message Y ---> X(parent)
       if size(k,1) == 1
         lambda_X{Y,X}(1,1) = prob{Y}(1,1)*lambda(Y,1) + prob{Y}(2,1)*lambda(Y,2);
         lambda_X{Y,X}(2,1) = prob{Y}(1,2)*lambda(Y,1) + prob{Y}(2,2)*lambda(Y,2);

       % Else, we need to use the Pi message sent from k(other parent) ---> Y 
       elseif size(k,1) == 2
         k = k(k ~= X);
         lambda_X{Y,X}(1,1) = prob{Y}(1,1)*pi_Y{k,Y}(1,1)*lambda(Y,1) + prob{Y}(2,1)*pi_Y{k,Y}(1,1)*lambda(Y,2) + prob{Y}(1,2)*pi_Y{k,Y}(2,1)*lambda(Y,1) + prob{Y}(2,2)*pi_Y{k,Y}(2,1)*lambda(Y,2);
         lambda_X{Y,X}(2,1) = prob{Y}(1,3)*pi_Y{k,Y}(1,1)*lambda(Y,1) + prob{Y}(2,3)*pi_Y{k,Y}(1,1)*lambda(Y,2) + prob{Y}(1,4)*pi_Y{k,Y}(2,1)*lambda(Y,1) + prob{Y}(2,4)*pi_Y{k,Y}(2,1)*lambda(Y,2);
       
       elseif size(k,1) == 3
         k = k(k ~= X);
         lambda_X{Y,X}(1,1) = prob{Y}(1,1)*pi_Y{k(1),Y}(1,1)*pi_Y{k(2),Y}(1,1)*lambda(Y,1) + prob{Y}(2,1)*pi_Y{k(1),Y}(1,1)*pi_Y{k(2),Y}(1,1)*lambda(Y,2) + prob{Y}(1,2)*pi_Y{k(1),Y}(1,1)*pi_Y{k(2),Y}(2,1)*lambda(Y,1) + prob{Y}(2,2)*pi_Y{k(1),Y}(1,1)*pi_Y{k(2),Y}(2,1)*lambda(Y,2) + prob{Y}(1,3)*pi_Y{k(1),Y}(2,1)*pi_Y{k(2),Y}(1,1)*lambda(Y,1) + prob{Y}(2,3)*pi_Y{k(1),Y}(2,1)*pi_Y{k(2),Y}(1,1)*lambda(Y,2) + prob{Y}(1,4)*pi_Y{k(1),Y}(2,1)*pi_Y{k(2),Y}(2,1)*lambda(Y,1) + prob{Y}(2,4)*pi_Y{k(1),Y}(2,1)*pi_Y{k(2),Y}(2,1)*lambda(Y,2);
         lambda_X{Y,X}(2,1) = prob{Y}(1,5)*pi_Y{k(1),Y}(1,1)*pi_Y{k(2),Y}(1,1)*lambda(Y,1) + prob{Y}(2,5)*pi_Y{k(1),Y}(1,1)*pi_Y{k(2),Y}(1,1)*lambda(Y,2) + prob{Y}(1,6)*pi_Y{k(1),Y}(1,1)*pi_Y{k(2),Y}(2,1)*lambda(Y,1) + prob{Y}(2,6)*pi_Y{k(1),Y}(1,1)*pi_Y{k(2),Y}(2,1)*lambda(Y,2) + prob{Y}(1,7)*pi_Y{k(1),Y}(2,1)*pi_Y{k(2),Y}(1,1)*lambda(Y,1) + prob{Y}(2,7)*pi_Y{k(1),Y}(2,1)*pi_Y{k(2),Y}(1,1)*lambda(Y,2) + prob{Y}(1,8)*pi_Y{k(1),Y}(2,1)*pi_Y{k(2),Y}(2,1)*lambda(Y,1) + prob{Y}(2,8)*pi_Y{k(1),Y}(2,1)*pi_Y{k(2),Y}(2,1)*lambda(Y,2);
       
       end
   
   
   %% Finding the children of X and store in "u"
    u = zeros(size(G,1),1);
        for i = 1:size(G,1)
                if G(X,i) == 1
                    u(i,1) = i;
                end
        end
    u = u(any(u,2),:);
    
    %% Checking for number of children of X
    if size(u,1) == 2
        % If two children store each of them in "i" and "j"
        i = u(1); j = u(2);
        % Then finding the product for each of x = 0, x = 1
        % Lambda message is send from i(child) ---> X and j(child) ---> X
        lambda(X,1) = lambda_X{i,X}(1,1)*lambda_X{j,X}(1,1);
        lambda(X,2) = lambda_X{i,X}(2,1)*lambda_X{j,X}(2,1);
        
    elseif size(u,1) == 1
        % If there is only one child Lambda message is sent from i(child) ---> X
        i = u(1);
        lambda(X,1) = lambda_X{i,X}(1,1);
        lambda(X,2) = lambda_X{i,X}(2,1);
        
    elseif size(u,1) == 3
        % If three children
        i1 = u(1); i2 = u(2); i3 = u(3);
        lambda(X,1) = lambda_X{i1,X}(1,1)*lambda_X{i2,X}(1,1)*lambda_X{i3,X}(1,1);
        lambda(X,2) = lambda_X{i1,X}(2,1)*lambda_X{i2,X}(2,1)*lambda_X{i3,X}(2,1);
        
    elseif size(u,1) == 4
        % If four children
        i1 = u(1); i2 = u(2); i3 = u(3); i4 = u(4);
        lambda(X,1) = lambda_X{i1,X}(1,1)*lambda_X{i2,X}(1,1)*lambda_X{i3,X}(1,1)*lambda_X{i4,X}(1,1);
        lambda(X,2) = lambda_X{i1,X}(2,1)*lambda_X{i2,X}(2,1)*lambda_X{i3,X}(2,1)*lambda_X{i4,X}(2,1);
        
    elseif size(u,1) == 5
        % If five children
        i1 = u(1); i2 = u(2); i3 = u(3); i4 = u(4); i5 = u(5);
        lambda(X,1) = lambda_X{i1,X}(1,1)*lambda_X{i2,X}(1,1)*lambda_X{i3,X}(1,1)*lambda_X{i4,X}(1,1)*lambda_X{i5,X}(1,1);
        lambda(X,2) = lambda_X{i1,X}(2,1)*lambda_X{i2,X}(2,1)*lambda_X{i3,X}(2,1)*lambda_X{i4,X}(2,1)*lambda_X{i5,X}(2,1);
    end
    
    %% Finding the P-tilda for x=0, x=1, which is product of lambda and pi value
    p_tilda{X}(1,1) = lambda(X,1)*pi(X,1);
    p_tilda{X}(2,1) = lambda(X,2)*pi(X,2);
    
    %% Normalizing each of the probabilities
    cond_prob{X}(1,1) = p_tilda{X}(1,1)/(p_tilda{X}(1,1) + p_tilda{X}(2,1));
    cond_prob{X}(2,1) = p_tilda{X}(2,1)/(p_tilda{X}(1,1) + p_tilda{X}(2,1));    
    
    %% Finding the parents of X and storing in "m"
    m = zeros(size(G,1),1);
        for i = 1:size(G,1)
                if G(i,X) == 1
                   m(i,1) = i;
                end
        end
    m = m(any(m,2),:);
    
    %% Send Lambda message from m(child of X) ---> X(parent)
    if size(m,1) ~= 0
        for i = 1:size(m,1)
            % Evidence should not have "m"
            if m(i) ~= E
                send_lambda_message(X,m(i));
            end
        end
    end
    
    %% Send Pi message from X ---> u(child of X), u is the child other than Y
    if size(u,1) ~= 0
        for j = 1:size(u,1)
            if u(j) ~= Y
                send_pi_message(X,u(j));
            end
        end
    end
 end