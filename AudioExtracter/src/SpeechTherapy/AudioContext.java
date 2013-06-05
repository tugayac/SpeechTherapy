/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SpeechTherapy;

/**
 *
 * @author tugayac
 */
public class AudioContext {
    private int bitrate;
    private int channel;
    private int samplingRate;
    private String filetype;
    
    public AudioContext() {
        this.bitrate = 0;
        this.channel = 0;
        this.samplingRate = 0;
        this.filetype = "N/A";
    }
    
    public AudioContext(String bitrate, String channel, String samplingRate, String filetype) {
        this.bitrate = Integer.parseInt(bitrate);
        this.channel = Integer.parseInt(channel);
        this.samplingRate = Integer.parseInt(samplingRate);
        this.filetype = filetype;
    }
    
    public AudioContext(int bitrate, int channel, int samplingRate, String filetype) {
        this.bitrate = bitrate;
        this.channel = channel;
        this.samplingRate = samplingRate;
        this.filetype = filetype;
    }
    
    public int getBitrate() {
        return bitrate;
    }

    public void setBitrate(int bitrate) {
        this.bitrate = bitrate;
    }

    public int getChannel() {
        return channel;
    }

    public void setChannel(int channel) {
        this.channel = channel;
    }

    public int getSamplingRate() {
        return samplingRate;
    }

    public void setSamplingRate(int samplingRate) {
        this.samplingRate = samplingRate;
    }
    
    public String getFiletype() {
        return filetype;
    }

    public void setFiletype(String filetype) {
        this.filetype = filetype;
    }
}
