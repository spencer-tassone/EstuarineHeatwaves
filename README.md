# EstuarineHeatwaves
Co-occurrence of aquatic heatwaves with atmospheric heatwaves, low dissolved oxygen, and low pH events in estuarine ecosystems. In Review @ Estuaries and Coasts.
Authors: Spencer J. Tassone, Alice F. Besterman, Cal D. Buelo, Jonathan A. Walter, Michael L. Pace

# The heat wave metrics: https://github.com/ajsmit/RmarineHeatWaves/blob/master/README.Rmd

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
