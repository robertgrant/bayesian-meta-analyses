# bayesian-meta-analyses
Material in the making of the paper "Not enough meta-analyses use Bayesian methods: a scoping review, 2005-2015"

Research questions
-----------

Q1. how many meta-analyses in biomedical topics have used Bayesian methods? is there evidence of increasing or decreasing use over time?
Q2. how reproducible are the meta-analyses:
Q2a. is code provided?
Q2b. are data provided?
Q2c. is the software version named? What software was used, and is it open-source?
Q3. what "ancestors" (Arksey &amp; O'Malley) are cited for Bayesian MA?
Q4. what problems is it used for?
Q5. do the authors report it as successful?
Q6. what sort of model is employed?
Q7. what sort of priors are employed?
Q8a. did they use both frequentist and Bayesian versions of the same analysis?
Q8b. if so, do they justify this?

Overview of process
----------

Medline and Cinahl search results (2005-2015 inclusive) including abstracts go into text files:
* medline-bayes
* medline-MA
* cinahl-bayes
* cinahl-MA
(these searches are too big to fill up my Github account when I'd be surprised if anyone ever wanted to look at them, but you can send me a fileshare request with something like ZendTo if you really want them)

Searches were run on 13 August 2015 (Cinahl) and 14 August 2015 (Medline). Note that the two databases produce text output in different formats, and also cinahl-MA and cinahl-bayes are a bit different to each other. I then found it helpful to get rid of extra lines in *medline-MA.txt* using *extraline.cpp*, which created a new version called *medline-MA2.txt*. Then, titles and authors were extracted into files with names like *cinahl-MA-titles.txt*, using these C++ programs:
* get-medline-titles.cpp
* get-medline-authors.cpp
* get-cinahl-MA-titles.cpp
* get-cinahl-MA-authors.cpp
* get-cinahl-bayes-titles.cpp
* get-cinahl-bayes-authors.cpp

*collapse-medline.cpp* reduces these author and title files to a compact form. *find-duplicates.R* looks at the first author's surname and the first six words of the titles and flags up matches in *potential-duplicates-MA.csv* (n=1866). The latter file was checked manually and reduced to *confirmed-duplicates-MA.csv* (n=1849). For the bayes results, *find-duplicates.cpp* did the matching and wrote them to *potential-duplicates-bayes.txt*; all the bayes duplicates appeared genuine. Then *cinahl-bayes-dups-removed.txt* and *cinahl-MA-dups-removed.txt* contain the search results with duplicates removed (because cinhal is the smaller set of results). Because the MA search strategy will include the bayes results too, we identify their numbers using *which-MA-titles-are-in-Bayes.cpp*, and results are listed in *which-medline.txt* and *which-cinahl.txt*; I haven't removed them from the MA files because there is no gain - the MA papers are just counted and the corresponding bayes counts are a proportion of them.

Those that are not relevant are listed in *abstract-screening-exclusions.txt*. Those that couldn't be obtained through KU or SGUL are listed in *not-available.txt*. Data extraction appears in here from the British Library visits, and has been copied over into *cinahl-bayes-fulltext-notes.txt* and *medline-bayes-fulltext-notes.txt* (see below).

The *medline-MA.txt* search results have been split (using *filesplitter.cpp*) into *split1.csv ... split14.csv* (these are not really csv files, that's just a filesplitter default). This is for any quick inspection of the format or specific papers, because the whole file is too big to bother opening.</p>

Data extraction goes into *cinahl-bayes-fulltext-notes.txt* and *medline-bayes-fulltext-notes.txt*. Along the way some more duplicates were found for bayes papers and noted in *additional-duplicates*; they got removed from cinahl.

The facts then get extracted into a data table in R using *fact-extraction.R* and the year comes from Medline using *get-medline-MA-citations.cpp* and *get-medline-bayes-citations.cpp* then *get-medline-years.R* and likewise *get-cinahl-MA-citations.cpp*, *get-cinahl-bayes-citations.cpp* then *get-cinahl-years.R*. This all gets exported as *allfacts.csv*, then annotated manually. It all ends up in *allfacts.csv*.

We might be missing MAs that don't mention Bayes or credible in the abstract or title. To estimate the extent of this, we look for "network meta", "indirect treatment", "mixed treatment comparison" in the abstracts of the non-Bayes medline (bayes papers have to manually excluded because they are still in there), pick a sample and look at full-text to see if they are bayesian. No further attempt is made to include them. The sample size (81) is chosen to obtain a posterior beta distribution, assuming a prevalence of 40%, with credible interval not extending outside 30-50%. A prior of beta(2,3) is assumed for this (weak expectation of some missed Bayesian papers, with mean prevalence of 40%). Coded in *NMA_samplesize.R*. The search in each splitfile is done by *nonbayes-NMA-search.R* and results go into *nonbayes-NMA-search-results*.csv*, then the sampling is done by *nonbayes-NMA-sample.R*.

Update search
--------

In January 2018, I revisited the project to move it along. 2015 and 2016's entries on the databases were complete by this point, so I thought we ought to update the search. I did this at the British Library but unlike the original search, we can't access full-text (there's no funding for this and I'm no longer an academic). We will include the update search just for question 1 and a simple classification as NMA or other (relating to question 4).
I did this:
* run the searches for 2015-16, save into text files
* extract authors and titles
* for MEDLINE, I wrote a new **get-medline-update-titles-and-authors.cpp** program to pull out everything in one pass
* for CINAHL, the export format has changed; they get reduced by **cinahl-update-author-title-year.R**, which saves **cinahl-update-MA-authors.txt**, *vel sim.*
* Files ending **...15-16.txt** have 2017 removed (these searches are too big to fill up my Github account when I'd be surprised if anyone ever wanted to look at them, but you can send me a fileshare request with something like ZendTo if you really want them)
* Avoid duplicating the 2015 publications already in all-facts.csv; use a new **allfacts-updated.xlsx**
* checked the Bayesian papers manually on 29 Jan 2018, listing duplicates in **update-bayes-duplicates.txt**. **medline-update-bayes-titles-nodups.txt** and **...-authors-nodups.txt** have those that survived this process.
* The non-Bayesian papers are screened in R using **update-MA-dups.R**
* check Bayesian abstracts for non-Bayes, methodological and other exclusions, then add to **allfacts-updated.xlsx**
* for all years, classification as NMAs or not is in **nma.csv**
* update stats and charts

Credit where it's due
--------

Painful though it is to open up every excrescence of this organically-evolving and ugly process here, I hope it makes it possible to retrace my steps, or to adapt my code, or just inspires someone else to do the same. Reproducible research matters. I reviewed a lot of poor papers for this project, and one stood out head and shoulders above the rest for transparency and completeness of publication in print and online; that was the work of PyMC3 dev Chris Fonnesbeck. His work inspired me to do this.
