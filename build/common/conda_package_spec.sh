conda_package_spec() {
  package_name="$1"
  package_version="$2"

  case "${package_version}" in
    develop)
      echo "lsstts/label/dev::${package_name}"
      ;;
    main)
      echo "lsstts::${package_name}"
      ;;
    *)
      echo "${package_name}=${package_version}"
      ;;
  esac
}
