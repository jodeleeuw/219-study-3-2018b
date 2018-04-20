To run your model:

1. Put the .R file that implements the model in the models/ folder.
2. Open model-tester.R
3. Change line 13 to point to the file that contains your model instead of "models/random-model.R"
4. Run the entire model-tester.R script.

This will generate a dataset called data.result. Open that using the built-in RStudio object viewer. There are 2430 trials from the experiment. Each entry in data.result will contain the target musical concept, the set of options, the response given by the subject in the experiment, and the response your model gave.
