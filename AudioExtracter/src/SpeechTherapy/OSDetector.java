/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SpeechTherapy;

/**
 *
 * @author tugayac
 */
public class OSDetector {
    private String os;
    
    public OSDetector() {
        this.os = System.getProperty("os.name").toLowerCase();
    }
    
    public boolean isWindows() {
        return this.os.contains("win");
    }
    
    public boolean isMac() {
        return this.os.contains("mac");
    }
    
    public boolean isUnix() {
        return this.os.contains("nix") || this.os.contains("nux") || this.os.contains("aix");
    }
}
