class maestro_nodes::mail(
  $name,
  $address,
) {
  $mail_from = {
    name    => $name,
    address => $address,
  }
}
