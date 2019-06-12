import time
# To starting time is stored to find the total time of execution
start = time.time()

print("Linear Regression Predictive Model accruracy:")

#The train_test_split is called to split the data into training and testing
from sklearn.model_selection import train_test_split

import pandas as pd
pd.set_option('display.max_columns', None)

#The data is uploaded to pandas from the excel file
data = pd.read_excel("C:\\Users\\junaid\\Downloads\\Data_Analyst_Assignment_v1.0.xlsx", sheet_name="Customer_Data")
#print(type(data))

#Spliting the data to prediction value and target value
#Here the X is predtction values and Y is the Target Values
X=pd.DataFrame(data,index=None,columns=["State","Specialty Code","Region","Call Attempts","Calls Successfully Completed","Emails Sent","Emails Opened","Faxes Sent","Total Market (Branded + Unbranded) Sales"])
Y=pd.DataFrame(data,index=None,columns=["Customer ID","Brand 1 Sales (Company's Brand)"])

Y = Y.drop(columns='Customer ID')

#filling zero in all NAN places
X = X.fillna(0)
Y = Y.fillna(0)

#Normalizing the target values to get proper output
Y["Brand 1 Sales (Company's Brand)"].value_counts(normalize=True)



#print(X)
#print(Y)
#X.info()
#Y.info()

#print(X)
#Adding dummies in the categorical values places in order to train model
#Here each categorical value will be converted to appropriate interger values 
X=pd.get_dummies(X)

#Using train_test_split the 75% data is used fro training and 25% data is used for testing 
#The training data is stored in X_train and Y_train
#The testing data is stored in X_test and Y_test 
X_train, X_test, y_train, y_test = train_test_split(X, Y, train_size=0.75, test_size=0.25, random_state=42, shuffle=True)

#linear_model is imported to train linear regression model
from sklearn import linear_model
lm = linear_model.LinearRegression()
#will fit the linear regression model with the test data
model = lm.fit(X_train,y_train)

from sklearn import metrics 

from sklearn.metrics import accuracy_score

#predicting the value of the test subject X_test and stores the predictions in variable predictions
predictions = lm.predict(X_test)
#print(predictions)
#calcualting the mean squared error
#print(y_test)
#print(metrics.mean_squared_error(y_test["Brand 1 Sales (Company's Brand)"],predictions))
#calculating the accuracy comapring the predicted value and real value
accuracy = lm.score(X_test,y_test)
print(accuracy*100,'%')

#The end time is stored in end 
end = time.time()
print("Time for Execution:")
#the total exectution time is printed
print(end - start)