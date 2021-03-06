function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

fprintf('size of Theta1_grad is %d \n', size(Theta1_grad));%25*401
fprintf('size of Theta2_grad is %d \n', size(Theta2_grad));%10*26

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m

X = [ones(m,1) X];
fprintf('size of X is %d \n', size(X));

%trun number vector(5000*1) to 0/1 matrix 5000*10
vecter_y = eye(num_labels);
fprintf('size of y is %d \n', size(vecter_y(y,:)));
y = vecter_y(y,:)

a1 = X; %5000*401
z2 = a1*Theta1'; %5000*25
a2 = [ones(m,1) sigmoid(z2)]; %5000*26
z3 = a2*Theta2'; %5000*10
a3 = sigmoid(z3); %5000*10
fprintf('size of a3 is %d \n', size(a3))
J = 1/m*sum(sum(-y.*log(a3)-(ones(size(y))-y).*log(ones(size(a3))-a3)));

%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
delta3 = a3-y; %5000*10
delta2 = (delta3*Theta2).*sigmoidGradient([ones(m,1) z2]); %5000*26
delta2 = delta2(:,2:end); %5000*25
fprintf('size of delta2 is %d \n', size(delta2));
Theta1_grad_temp = 0;
Theta2_grad_temp = 0;
Theta1_grad_temp = Theta1_grad_temp + (delta2'*a1);
Theta2_grad_temp = Theta2_grad_temp + (delta3'*a2);
Theta1_grad = 1/m.*Theta1_grad_temp;
Theta2_grad = 1/m.*Theta2_grad_temp;
fprintf('size of theta1_grad is %d \n', size(Theta1_grad));
fprintf('size of theta2_grad is %d \n', size(Theta2_grad));

 
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
J = J + lambda/(2*m).*(sum(sum(Theta1(:,2:end).^2))+sum(sum(Theta2(:,2:end).^2)));


















% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];
%regularized 
% Theta1_reg = [zeros(size(Theta1,1),1) Theta1(:,2:end)];
% Theta2_reg = [zeros(size(Theta2,1),1) Theta2(:,2:end)];
% Theta1_grad = Theta1_grad + lambda/m.*Theta1_reg;
% Theta2_grad = Theta2_reg  + lambda/m.*Theta2_reg;
% grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
