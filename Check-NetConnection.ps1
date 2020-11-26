function Check-NetConnection($computername,$port,$timeout=200,$verbose=$false) {
            $tcp = New-Object System.Net.Sockets.TcpClient;
            try {
                $connect=$tcp.BeginConnect($computername,$port,$null,$null)
                $wait = $connect.AsyncWaitHandle.WaitOne($timeout,$false)
                if(!$wait){
                    $null=$tcp.EndConnect($connect)
                    $tcp.Close()
                    if($verbose){
                        Write-Host "Connection Timeout" -ForegroundColor Red
                        }
                    Return $false
                }else{
                    $error.Clear()
                    $null=$tcp.EndConnect($connect) 
                    if(!$?){
                        if($verbose){
                            write-host $error[0].Exception.Message -ForegroundColor Red
                            }
                        $tcp.Close()
                        return $false
                        }
                    $tcp.Close()
                    Return $true
                }
            } catch {
                return $false
            }
    }
