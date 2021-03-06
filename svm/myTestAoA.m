

X = load('testXtrain.mat');
training_instance_matrix = X.Xtrain';
Y = load('testYtrain.mat');
training_label_vector = Y.Ytrain';
training_label_vector = training_label_vector/(2*pi);

tic;
model = svmtrain(training_label_vector, training_instance_matrix,...
    's 3 p 0.1 t 0 nr_class 2');
toc;

X2 = load('testXtest.mat');
testing_instance_matrix = X2.Xtest';
Y2 = load('testYtest.mat');
testing_label_vector = Y2.Ytest';
testing_label_vector = testing_label_vector/(2*pi);

[predicted_label] = svmpredict(testing_label_vector,  ...
                                testing_instance_matrix, ...
                                model, 's 3 p 0.1 t 0');
                            
acc = sum(Ypred == Ytest)./numel(Ytest)

Ypred = double(predicted_label)';
Ytest = double(testing_label_vector)';
plotConfMat(myCalConfusionMatrix(Ytest,Ypred), intfName);
saveas(gcf,'confusionMatrix.png');