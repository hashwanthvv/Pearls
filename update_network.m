function [] = update_network(V,v)
    
     %% Globalising our variables
     global G
     global E
     global e
     global prob
     global pi_Y
     global lambda
     global pi
     global cond_prob
     global lambda_X
     global p_tilda
     
     %% Updating our Evidence set and evidence value
     E = cat(1,E,V);
     e = cat(1,e,v);
     
     %% For the value of v that is matched, setting parameters to unity, else zero
     if v == 1
         lambda(V,1) = 1; lambda(V,2) = 0;
         pi(V,1) = 1; pi(V,2) = 0;
         cond_prob{V}(1,1) = 1;  cond_prob{V}(2,1) = 0; 
     elseif v == 2
         lambda(V,1) = 0; lambda(V,2) = 1;
         pi(V,1) = 0; pi(V,2) = 1;
         cond_prob{V}(1,1) = 0;  cond_prob{V}(2,1) = 1;  
     end
     %% For the parents of V(not in evidence), send_lambda_message V ---> i(parent)
        for i = 1:size(G,1)
                if (G(i,V) == 1) && ~ismember(i,E)
                    send_lambda_message(V,i);
                end
        end
     
     %% For the children of V, send_pi_message V ---> j(child)
        for j = 1:size(G,1)
                if G(V,j) == 1
                    send_pi_message(V,j);
                end
        end
        
end
