# Functions for Classification-project

import pandas as pd
import numpy as np

import matplotlib.pyplot as plt
import seaborn as sns

import scipy.stats as stats
from scipy.stats import chi2_contingency

from sklearn.preprocessing import Normalizer, StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.neighbors import KNeighborsClassifier
from sklearn.tree import DecisionTreeClassifier

from sklearn import metrics
from sklearn.metrics import confusion_matrix

import scikitplot as skplt

# function which sorts columns into list depending on a self chosen threshold: discrete VS contiuous variables
# needs to be improved --> how to save lists as a variable which can be saved outside of the function?
def continuous_discrete(df, threshold):
    
    lst_discrete = []
    lst_continuous = []
        
    for col in df.columns:

        if df[col].nunique() <= threshold:
            lst_discrete.append(col)
        else:
            lst_continuous.append(col)
        
    print('The following columns are discrete with a value count of equal or less than ', threshold, ': ', lst_discrete)
    print('The following columns are continuous with a value count of more than', threshold, ': ',lst_continuous)
    
    return lst_discrete, lst_continuous

# function to show countplot for discrete variables and histplot for continuous variables
# needs to be improved --> subplots aren't shown next to each other yet!
def showing_count_dist(df, discrete=[], continuous=[], skip_columns=[]):
   
    for col in df.columns:
        if col not in skip_columns:
            fig, axes = plt.subplots(1, 2, figsize=(15, 5))
            # sns.set_style("darkgrid")

            if col in discrete:
                sns.countplot(df[col], ax=axes[0])
            elif col in continuous:
                sns.histplot(df[col], ax=axes[1])

            plt.show()

# function to show countplot with hue            
def showing_count_hue(df, in_columns=[], skip_columns=[], target=''):
    for col in df.columns:
        if col in in_columns:
            if col not in skip_columns:
                sns.countplot(df[col], hue=target, data=df)
                plt.show()
                
# function to clean headers (column names)
def clean_headers(df):
    df.columns = df.columns.str.lower().str.replace(' ', '_').str.replace('#', 'number')
    return df

# function to create data frame showing percentage of NaN-values in columns
def per_NaN_columns(df):
    nulls = pd.DataFrame(df.isna().sum()*100/len(df), columns=['percentage_nulls'])
    nulls.sort_values('percentage_nulls', ascending = False)
    return nulls

# function to create data frame showing percentage of NaN-values in rows
# needs to be adjusted! --> placeholder for '16' to automatically add number of columns
def per_NaN_rows(df):
    nulls_r = pd.DataFrame(df.isna().sum(axis=1)*100/16, columns=['percentage_nulls'])
    nulls_r.sort_values('percentage_nulls', ascending = False)
    return nulls_r

# function to fill in NaN-values
# needs to be adjusted! --> currently only works for numerical columns
def fill_NaN(df, in_column=[], skip_column=[]):
    for col in in_column:
        if col not in skip_column:
            mean_val = df[col].mean()
            df[col] = df[col].fillna(mean_val)    
    return df

# function to plot distribution for numerical columns with seaborn-library
def showing_dist(df):
    for col in df.select_dtypes(np.number):
        sns.distplot(df[col])
        plt.show()

# function to plot outliers for numerical columns with seaborn-library        
def showing_boxplots(df):
    for col in df.select_dtypes(np.number):
        sns.boxplot(df[col])
        plt.show()
        
# function to perform boxcox-transformation
def boxcox_transform(df, skip_columns=[]):
    numeric_cols = df.select_dtypes(np.number).columns
    _ci = {column: None for column in numeric_cols}
    for column in numeric_cols:
        if column not in skip_columns:
            df[column] = np.where(df[column]<=0, np.NAN, df[column]) 
            df[column] = df[column].fillna(df[column].mean())
            transformed_data, ci = stats.boxcox(df[column])
            df[column] = transformed_data
            _ci[column] = [ci] 
    return df, _ci 

# function to cut outliers at a specific threshold
def cutting_outliers(df, threshold=1.5, in_columns=[], skip_columns=[]):
    for column in in_columns:
        if column not in skip_columns:
            upper = np.percentile(df[column],75)
            lower = np.percentile(df[column],25)
            iqr = upper - lower
            upper_limit = upper + (threshold * iqr)
            lower_limit = lower - (threshold * iqr)
            df.loc[df[column] > upper_limit, column] = upper_limit
            df.loc[df[column] < lower_limit, column] = lower_limit
    return df

# function to perform ChiSquare-test for all (categorical) variables
def chi_square_all(df, columns=[]):
    for i in columns:
        for j in columns:
            if i != j:
                data_crosstab = pd.crosstab(df[i], df[j], margins = False)
                print('ChiSquare test for ',i,'and ',j,': ')
                print(chi2_contingency(data_crosstab, correction=False), '\n')

# function to show accuracy score + value counts for Logistic Regression Model
def classification_model(X_train, y_train, X_test, y_test, w):
    classification = LogisticRegression(random_state=42, max_iter=500, class_weight=w) 
    classification.fit(X_train, y_train)
    
    score_class = classification.score(X_test, y_test)
    
    predictions = classification.predict(X_test)
    value_cnt_class = pd.Series(predictions).value_counts()
    
    print('The accuracy score is: ', score_class, '\n')
    print('The value counts of the model predictions are: ', '\n', value_cnt_class)                

# function to print relevant metrics for Logistic Regression Model
# confusion matrix only works for binary classification problems!    
def metrics_classification(X_train, y_train, X_test, y_test, w):
    
    classification = LogisticRegression(random_state=42, max_iter=500, class_weight=w) 
    classification.fit(X_train, y_train)
    
    predictions = classification.predict(X_test)
    
    #confusion matrix
    cf_matrix = confusion_matrix(y_test, predictions)
    group_names = ['True A', 'False A',
                   'False B', 'True B']

    group_counts = ["{0:0.0f}".format(value) for value in cf_matrix.flatten()]
    group_percentages = ["{0:.2%}".format(value) for value in cf_matrix.flatten()/np.sum(cf_matrix)]
    labels = [f"{v1}\n{v2}\n{v3}" for v1, v2, v3 in zip(group_names,group_counts,group_percentages)]
    labels = np.asarray(labels).reshape(2,2)
    
    print('Confusion matrix:')
    sns.heatmap(cf_matrix, annot=labels, fmt='', cmap='Blues')
    
    #ROC-AUC
    y_probas = classification.predict_proba(X_test)

    skplt.metrics.plot_roc_curve(y_test, y_probas)
    plt.show()
    
    #classification report
    metrics_class = metrics.classification_report(y_test, predictions)
    print('Classification report:', '\n')
    print(metrics_class)    
    
# function to show accuracy score + value counts for KNN-Algorithm    
def KNN_model(X_train, y_train, X_test, y_test, i):
    model = KNeighborsClassifier(n_neighbors=i)
    model.fit(X_train, y_train)
    
    predictions_knn = model.predict(X_test)
    score_knn = metrics.accuracy_score(y_test, predictions_knn)
    
    value_cnt_knn = pd.Series(predictions_knn).value_counts()
    
    print('The accuracy score is: ', score_knn, '\n')
    print('The value counts of the model predictions are: ', '\n', value_cnt_knn)
    
# function to check best value for K (for KNN-Algorithm)    
def best_K(X_train, y_train, X_test, y_test, r):
    scores = []
    for i in r:
        model = KNeighborsClassifier(n_neighbors=i)
        model.fit(X_train, y_train)
        scores.append(model.score(X_test, y_test))
        
    plt.figure(figsize=(10,6))
    plt.plot(r,scores,color = 'blue', linestyle='dashed',
             marker='*', markerfacecolor='red', markersize=10)
    plt.title('accuracy scores vs. K Value')
    plt.xlabel('K')
    plt.ylabel('Accuracy')   
    
# function to print relevant metrics for KNN-Algorithm
# confusion matrix only works for binary classification problems!
def metrics_KNN(X_train, y_train, X_test, y_test, i):
    
    model = KNeighborsClassifier(n_neighbors=i) 
    model.fit(X_train, y_train)
    
    predictions_knn = model.predict(X_test)
    
    #confusion matrix
    cf_matrix = confusion_matrix(y_test, predictions_knn)
    group_names = ['True A', 'False A',
                   'False B', 'True B']

    group_counts = ["{0:0.0f}".format(value) for value in cf_matrix.flatten()]
    group_percentages = ["{0:.2%}".format(value) for value in cf_matrix.flatten()/np.sum(cf_matrix)]
    labels = [f"{v1}\n{v2}\n{v3}" for v1, v2, v3 in zip(group_names,group_counts,group_percentages)]
    labels = np.asarray(labels).reshape(2,2)
    
    print('Confusion matrix:')
    sns.heatmap(cf_matrix, annot=labels, fmt='', cmap='Blues')
    
    #ROC-AUC
    y_probas = model.predict_proba(X_test)

    skplt.metrics.plot_roc_curve(y_test, y_probas)
    plt.show()
    
    #classification report
    metrics_knn = metrics.classification_report(y_test, predictions_knn)
    print('Classification report:', '\n')
    print(metrics_knn)


# function to show accuracy score + value counts for Decision Tree Model    
def decision_tree_model(X_train, y_train, X_test, y_test):
    tree = DecisionTreeClassifier() 
    tree.fit(X_train, y_train)
    
    score_tree = tree.score(X_test, y_test)
    
    predictions_tree = tree.predict(X_test)
    value_cnt_tree = pd.Series(predictions_tree).value_counts()
    
    print('The accuracy score is: ', score_tree, '\n')
    print('The value counts of the model predictions are: ', '\n', value_cnt_tree)

# function to print relevant metrics for Decision Tree Model
# confusion matrix only works for binary classification problems!
def metrics_tree(X_train, y_train, X_test, y_test):
    
    tree = DecisionTreeClassifier() 
    tree.fit(X_train, y_train)
    
    predictions_tree = tree.predict(X_test)
    
    #confusion matrix
    cf_matrix = confusion_matrix(y_test, predictions_tree)
    group_names = ['True A', 'False A',
                   'False B', 'True B']

    group_counts = ["{0:0.0f}".format(value) for value in cf_matrix.flatten()]
    group_percentages = ["{0:.2%}".format(value) for value in cf_matrix.flatten()/np.sum(cf_matrix)]
    labels = [f"{v1}\n{v2}\n{v3}" for v1, v2, v3 in zip(group_names,group_counts,group_percentages)]
    labels = np.asarray(labels).reshape(2,2)
    
    print('Confusion matrix:')
    sns.heatmap(cf_matrix, annot=labels, fmt='', cmap='Blues')
    
    #ROC-AUC
    y_probas = tree.predict_proba(X_test)

    skplt.metrics.plot_roc_curve(y_test, y_probas)
    plt.show()
    
    #classification report
    metrics_tree = metrics.classification_report(y_test, predictions_tree)
    print('Classification report:', '\n')
    print(metrics_tree)