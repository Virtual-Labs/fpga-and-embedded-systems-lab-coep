package extra;

import java.io.Serializable;
public class StatusBean implements Runnable, Serializable {
private boolean status;

public StatusBean() {
status = false;
}

public synchronized boolean isCompleted() {
return status;
}

public synchronized void setStatus(boolean status) {
this.status = status;
}

public void run() {
try{
Thread.sleep(20000);
this.status = true;
}catch(InterruptedException e){
e.printStackTrace();
}
}
}
