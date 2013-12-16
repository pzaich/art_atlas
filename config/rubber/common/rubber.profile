<%
  @path = "/etc/profile.d/rubber.sh"
  current_path = "/mnt/#{rubber_env.app_name}-#{Rubber.env}/current" 
%>

# convenience to simply running rails console, etc with correct env
export RUBBER_ENV=<%= Rubber.env %>
export RAILS_ENV=<%= Rubber.env %>
export AWS_ACCESS_KEY=AKIAIMQNWDONKHWO5YIQ
export AWS_SECRET_KEY=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
export ART_NEAR_ME_BING_API_KEY=AvJ0OqIzT2GwnWNbwWLuc3k1ol1mYi_jOyOh5ZGT-I8FoTJnm8hXy-pt9Qxq61YH
alias current="cd <%= current_path %>"
alias release="cd <%= Rubber.root %>"
