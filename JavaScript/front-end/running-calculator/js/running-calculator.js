var RunningCalculator = (function() {
    // There are 3,600 seconds in an hour
    var secondsPerHour = 3600;

    return {
        getSpeed: function(minutesPerMile, secondsPerMile) {
            // Calculate how many seconds it takes to cover a mile
            var secondsPerMile = (minutesPerMile * 60) + secondsPerMile;

            // Divide secondsPerHour by secondsPerMile to calculate how
            // many miles you cover in an hour at this pace
            return secondsPerHour / secondsPerMile;
        }
    }
})();
