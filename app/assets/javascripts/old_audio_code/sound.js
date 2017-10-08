

function make_sound(freq, audioCtx) {

    // create web audio api context
    //var audioCtx = new (window.AudioContext || window.webkitAudioContext)();
    
    // create Oscillator node
    if (window.oscillator != undefined)
	window.oscillator.stop()
    
    window.oscillator = audioCtx.createOscillator();
    
    oscillator.connect(audioCtx.destination);
    
    oscillator.type = 'sine';
    freq = Math.floor(freq);
    oscillator.frequency.value = freq; // value in hertz
    console.log("DEBUG playing sound", freq);
    
    oscillator.start();

    setTimeout(
	function(){
	    oscillator.stop();
	    window.oscillator = undefined;
	},
	1000
    );

    
    
    return;
}

function shuffle(array) {
  var currentIndex = array.length, temporaryValue, randomIndex;

  // While there remain elements to shuffle...
  while (0 !== currentIndex) {

    // Pick a remaining element...
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex -= 1;

    // And swap it with the current element.
    temporaryValue = array[currentIndex];
    array[currentIndex] = array[randomIndex];
    array[randomIndex] = temporaryValue;
  }

  return array;
}

function sum_array(array, index){
    var sum = array.reduce(function(pv, cv) { return pv + cv[index]; }, 0);
    return sum;
}

function CoarseToFineGenerator(min_range, max_range){
    n_coarse_tests = 8;
    n_fine_tests = 8;
    delta_coarse = (max_range - min_range) / n_coarse_tests;
    console.log("BEK", delta_coarse, max_range, min_range, n_coarse_tests);

    this.coarse_frequencies = Array();
    var first_freq = null;
    for(var i=0; i<n_coarse_tests; ++i){
        var freq = min_range + i*delta_coarse;
        if (i==0) first_freq = freq;
        else this.coarse_frequencies.push(freq);
    }
    //console.log("BEK", this.coarse_frequencies);
    this.delta_fine = delta_coarse / n_fine_tests;
    this.fine_frequencies = Array();
    for(var i=1; i<n_fine_tests; ++i){
        this.fine_frequencies.push(i*this.delta_fine);
    }
    //console.log("BEK", this.fine_frequencies);

    console.log("DEBUG", this.coarse_frequencies);
    this.coarse_frequencies = shuffle(this.coarse_frequencies);
    console.log("DEBUG", this.coarse_frequencies);
    this.fine_frequencies = shuffle(this.fine_frequencies);
    this.highest_coarse_audible = null;
    // Make sure the first sound is the lowest (safety and jokes)
    this.coarse_frequencies.push(first_freq);
    console.log("DEBUG", this.coarse_frequencies);


    this.generate=function(test_freqs){
        var return_freq = this.coarse_frequencies.pop();
        if (!return_freq){
            if (!this.highest_coarse_audible){
                this.highest_coarse_audible = 0;
                for (var i in test_freqs){
                    if(test_freqs[i][0] > this.highest_coarse_audible && test_freqs[i][1]){
                        this.highest_coarse_audible = test_freqs[i][0];
                    }
                }
            }
            console.log("DEBUG Using fine frequencies, starting at", this.highest_coarse_audible);
            if (this.highest_coarse_audible>22000) {
                    console.log("DEBUG Frequency is higher than reasonable range");
                    return null;
            }
            //this.highest_coarse_audible -= this.delta_fine/1.2;
            //console.log("BEK this.highest_coarse_audible",
            //this.highest_coarse_audible);
            var fine = this.fine_frequencies.pop();
            var return_freq = this.highest_coarse_audible + fine;
            //console.log("BEK highest_audible", highest_audible);
        }
        return return_freq;
    }
}

function generate_frequency(min_range, max_range, tested_vals) {
    if (!generator){
        generator = new CoarseToFineGenerator(min_range, max_range);
    }
    freq = generator.generate(tested_vals);
    return freq;
}

function generate_random_frequency(min_range, max_range) {

    var rand = min_range + Math.random()*(max_range - min_range);
    var freq = Math.floor(rand);

    return freq;
}

function finished_testing(tested_vals){
    var threshold = calc_threshold(tested_vals);
    console.log("Final threshold is", threshold);
    document.getElementById("main_text").innerHTML="Your threshold is "+threshold
    document.getElementById("myBtn").disabled=true;
    document.getElementById("yesBtn").disabled=true;
    document.getElementById("noBtn").disabled=true;
    document.getElementById("againBtn").disabled=true;
    have_finished = true;
    return threshold;
}

function calc_threshold(tested_vals){
    var sorted_freqs = test_freqs.sort(function(left, right){return left[0]>right[0];});
    var last_definite_heard_idx = 0;
    for (var index in sorted_freqs){
        var [freq, heard] = sorted_freqs[index];
        if (! heard) break;
        last_definite_heard_idx += 1;
    }
    var first_definite_not_heard_idx = sorted_freqs.length + 1;
    for (var index in sorted_freqs.reverse()){
        var [freq, heard] = sorted_freqs[index];
        if(heard) break;
        first_definite_not_heard_idx -= 1;
    }
    last_definite_heard_idx -= 1;
    sorted_freqs.reverse();
    var sum = 0;
    var count = 0;
    if (last_definite_heard_idx > -1 && first_definite_not_heard_idx < sorted_freqs.length ){
        for(var i=last_definite_heard_idx; i< first_definite_not_heard_idx; ++i){
            sum += sorted_freqs[i][0];
            count += 1;
        }
    }
    if (count == 0){
        if (last_definite_heard_idx == -1){
            return sorted_freqs[0][0];
        } else{
            var i = sorted_freqs.length -1;
            return sorted_freqs[i][0];
        }
    }
    return  sum /count;
}

function main(audioCtx, tested_vals) {
    //console.log("DEBUG", tested_vals.map(function(x){return x[0] + " " + x[1];}));

    var freq =  generate_frequency(200, 22000, tested_vals);
    if (!freq){
        finished_testing(tested_vals);
        
        return null;
    }else{
        make_sound(freq, audioCtx);
    }
    return freq;
}
