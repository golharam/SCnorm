#' @title Iteratively fit group regression and evaluate to choose optimal K

#' @description This function iteratively normalizes using K groups and then evaluates whether K is sufficient. If the maximum mode received 
#' from the GetK() function is larger than .1, K is increased to K + 1. Uses params sent from SCnorm.
#' @return matrix of normalized and scaled expression values for all conditions. If PLOT = TRUE then the evaluation plots are 
#' output for each attempted value of K.
#' @author Rhonda Bacher
#' @export

Normalize <- function(Data, SeqDepth, Slopes, CondNum, PLOT = TRUE, OutputName = OutputName, PropToUse, Tau, NCores, Thresh, ditherCounts) {
	# Set up
	GetMax = 1
	i = 0
	
	message(paste0("Finding K for Condition ", CondNum))
		while(GetMax > Thresh) {
			i = i + 1 
			message(paste0("Trying K = ", i))
			NormDataList <- SCnorm_fit(Data = Data, SeqDepth = SeqDepth, Slopes = Slopes, K = i, 
								PropToUse = PropToUse, Tau = Tau, NCores = NCores, ditherCounts=ditherCounts)
			
			NAME = paste0("Condition: ", CondNum, "\n K = ", i)
		
			GetMax <- GetK(NormDataList$NormData, SeqDepth, Data, Slopes, NAME, PLOT = PLOT, Tau=Tau, NCores = NCores, ditherCounts=ditherCounts)
			
			
		}
	
return(NormDataList)
}

