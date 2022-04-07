# EstuarineHeatwaves
Co-occurrence of aquatic heatwaves with atmospheric heatwaves, low dissolved oxygen, and low pH events in estuarine ecosystems. [This work was published online, Sept. 2021, in Estuaries and Coasts](https://doi.org/10.1007/s12237-021-01009-x).

Authors: Spencer J. Tassone*, Alice F. Besterman, Cal D. Buelo, Jonathan A. Walter, Michael L. Pace

*Contact author: sjt7jc@virginia.edu

# Abstract
Heatwaves are increasing in frequency, duration, and intensity in the atmosphere and marine environment with rapid changes to ecosystems occurring as a result. However, heatwaves in estuarine ecosystems have received little attention despite the effects of high temperatures on biogeochemical cycling and fisheries and the susceptibility of estuaries to heatwaves given their low volume. Likewise, estuarine heatwave co-occurrence with extremes in water quality variables such as dissolved oxygen (DO) and pH have not been considered and would represent periods of enhanced stress. This study analyzed 1440 station years of high-frequency data from the National Estuarine Research Reserve System (NERRS) to assess trends in the frequency, duration, and severity of estuarine heatwaves and their co-occurrences with atmospheric heatwaves, low DO, and low pH events between 1996 and 2019. Estuaries are warming faster than the open and coastal ocean, with an estuarine heatwave mean annual occurrence of 2 ± 2 events, ranging up to 10 events per year, and lasting up to 44 days (mean duration = 8 days). Estuarine heatwaves co-occur with an atmospheric heatwave 6–71% of the time, depending on location, with an average estuarine heatwave lag range of 0–2 days. Similarly, low DO or low pH events co-occur with an estuarine heatwave 2–45% and 0–18% of the time, respectively, with an average low DO lag of 3 ± 2 days and low pH lag of 4 ± 2 days. Triple co-occurrence of an estuarine heatwave with a low DO and low pH event was rare, ranging between 0 and 7% of all estuarine heatwaves. Amongst all the stations, there have been significant reductions in the frequency, intensity, duration, and rate of low DO event onset and decline over time. Likewise, low pH events have decreased in frequency, duration, and intensity over the study period, driven in part by reductions in all severity classifications of low pH events. This study provides the first baseline assessment of estuarine heatwave events and their co-occurrence with deleterious water quality conditions for a large set of estuaries distributed throughout the USA.

# The heat wave metrics
Table and most text in this section comes from the [heatwaveR README page](https://cran.rstudio.com/web/packages/heatwaveR/readme/README.html).

The function will return a list of two tibbles (see the 'tidyverse'), `clim` and `event`, which are the climatology and MHW (or MCS) events, respectively. The climatology contains the full time series of daily temperatures, as well as the the seasonal climatology, the threshold and various aspects of the events that were detected. The software was designed for detecting extreme thermal events, and the units specified below reflect that intended purpose. However, the various other kinds of extreme events may be detected according to the 'marine heat wave' specifications, and if that is the case, the appropriate units need to be determined by the user.

| Climatology metric | Description |
|--------------------|-------------|
|`doy` | Julian day (day-of-year). For non-leap years it runs 1...59 and   61...366, while leap years run 1...366. This column will be named differently if another name was specified to the `doy` argument. |
|`t` | The date of the temperature measurement. This column will be named differently if another name was specified to the `x` argument. |
|`temp` | If the software was used for the purpose for which it was designed, seawater temperature [deg. C] on the specified date will be returned. This column will of course be named differently if another kind of measurement was specified to the `y` argument. |
|`seas_clim_year` | Climatological seasonal cycle [deg. C]. |
|`thresh_clim_year` | Seasonally varying threshold (e.g., 90th percentile) [deg. C]. |
|`var_clim_year` | Seasonally varying variance (standard deviation) [deg. C]. |
|`thresh_criterion` | Boolean indicating if `temp` exceeds `thresh_clim_year`. |
|`duration_criterion` | Boolean indicating whether periods of consecutive `thresh_criterion` are >= `min_duration`. |
|`event` | Boolean indicating if all criteria that define a MHW or MCS are  met. |
|`event_no` | A sequential number indicating the ID and order of occurence of the MHWs or MCSs. |

The events are summarised using a range of event metrics:

| Event metric | Description |
|--------------|-------------|
|`index_start` | Start index of event. |
|`index_stop` | Stop index of event. |
|`event_no` | A sequential number indicating the ID and order of the events. |
|`duration` | Duration of event [days]. |
|`date_start` | Start date of event [date]. |
|`date_stop` | Stop date of event [date]. |
|`date_peak` | Date of event peak [date]. |
|`int_mean` | Mean intensity [deg. C]. |
|`int_max` | Maximum (peak) intensity [deg. C]. |
|`int_var` | Intensity variability (standard deviation) [deg. C]. |
|`int_cum` | Cumulative intensity [deg. C x days]. |
|`rate_onset` | Onset rate of event [deg. C / day]. |
|`rate_decline` | Decline rate of event [deg. C / day]. |

We used `int_cum_rel_thresh` in our analysis which have the same units as above and are relative to the threshold (e.g., 90th percentile) rather than the seasonal climatology.

Note that `rate_onset` and `rate_decline` will return `NA` when the event begins/ends on the first/last day of the time series or if there is a gap in the timeseries. Although the other metrics do not contain any errors and provide sensible values, please take this into account in its interpretation.


# Low pass filtering to remove influence of tides on estuarine water temperature, dissolved oxygen (DO), and pH time series

Per suggestion by a reviewer, we examined the influence of intra-tidal and intra-diurnal signals on the high-frequency (15 and 30 min. interval) estuarine water temperature, dissolved oxygen, and pH data. We did this by running the high frequency data through a low-pass filter prior to calculating daily averages (another type of low pass filtering) which we used in the extreme event detection algorithm [heatwaveR](https://cran.rstudio.com/web/packages/heatwaveR/readme/README.html). All the code for this analaysis is in the `Analysis` branch of this repository. In the code, there are two functions that are used to conduct the low pass filter: 1) lpfilt and 2) specclc. Each of these functions is in their own branch labelled as `lpfilt` and `specclc`. The low pass filtered data had small, random influences on the direction of the number of estuarine heatwaves, low DO, and low pH events.
