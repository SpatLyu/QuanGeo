library(blastula)

email = render_email('./dailywork/courses/quangeo/ask_sk.Rmd')

create_smtp_creds_key(
  id = "gmail",
  provider = "gmail",
  user = "lyu.geosocial@gmail.com",
  overwrite = T
)

create_smtp_creds_key(
  id = "163com",
  user = 'lwb_giser@163.com',
  host = "smtp.163.com",
  port = 25,
  use_ssl = T,
  overwrite = T
)

smtp_send(
  from = "lyu.geosocial@gmail.com",
  to = 'wenbo.lv@snnu.edu.cn',
  subject = enc2utf8('关于上课时询问的偏度问题'),
  email = email,
  credentials = creds_key("gmail")
)

smtp_send(
  from = 'lwb_giser@163.com',
  to = 'sybill548@163.com',
  subject = enc2utf8('关于上课时询问的偏度问题'),
  email = email,
  credentials = creds_key("163com")
)