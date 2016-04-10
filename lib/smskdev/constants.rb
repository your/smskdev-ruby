DEFAULT_URL     = 'https://www.smskdev.it/playsms/index.php'
DEFAULT_UNICODE = 1
DEFAULT_TYPE    = 'text'

OPERATIONS = {
  :get_token => { :op => 'get_token', :mandatory => ['u', 'p'], :optional => ['format'] },
  :send_sms  => { :op => 'pv', :mandatory => ['to', 'msg'], :optional => ['type', 'unicode', 'from', 'footer', 'nofooter', 'format'] },
  :status    => { :op => 'ds', :mandatory => [], :optional => ['queue', 'src', 'dst', 'dt', 'smslog_id', 'c', 'last', 'format'] },
}