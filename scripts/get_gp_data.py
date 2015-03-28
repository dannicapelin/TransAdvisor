from bs4 import BeautifulSoup
import yaml
import urllib2
import os


def create_gp_yaml():
    '''Returns an array of the GP data
    The array is of the form:
    [
        {
            "name": surgery_name,
            "address": surgery_address,
            "telephone": telephone_number
        },

        ...
    ]
    '''

    # Dictionary containing the GP data
    gp_data = []

    # First 65 results of GP addresses in WC1 N3AS.
    webaddress = (
        "http://www.nhs.uk/Service-Search/GP/wc1-n3as/Results/4/-0."
        "121923021972179/51.5205688476563/4/0?ResultsOnPageValue=65&"
        "isNational=0"
    )

    # Get html text
    html_data = urllib2.urlopen(webaddress).read()
    soup = BeautifulSoup(html_data)

    # Returns the relevent lists.
    # There are some implicit assumptions made here - that the order the
    # information is returned in is always the same, and is consistent across
    # the different data.
    address_names = grab_data(soup, "fcaddress")
    surgery_names = grab_data(soup, "fctitle")
    telephone_numbers = grab_data(soup, "fctel")
    links = grab_links(soup)

    # Check that our data is consistent!
    if len(address_names) != len(surgery_names):
        print '{} {} {}'.format(len(address_names), len(surgery_names))
        raise Exception(
            "Oops, we have a different number of surgeries and addresses. "
            "Something went wrong"
        )

    for i in range(len(address_names)):
        gp_dict = {}
        gp_dict["address"] = address_names[i]
        gp_dict["surgery"] = surgery_names[i]

        # TODO: This is VERY BAD.  We should sort each surgery individually,
        # but instead I grabbed the list of all the surgery names, numbers and
        # addresses, and this one is missing a telephone number
        if not surgery_names[i] == "Portsoken Health Centre":
            gp_dict["telephone"] = telephone_numbers[i]
        gp_dict["link"] = links[i]
        gp_data.append(gp_dict)

    # turn array into a yaml (optional)
    yaml_data = yaml.dump(gp_data)
    return yaml_data


def grab_links(soup):
    data = []

    for s in soup.find_all(class_="fctitle"):
        text = s.a["href"]
        text = text.encode('ascii', 'ignore')
        webaddress = "http://www.nhs.uk/" + text
        data.append(webaddress)

    return data


def write_yaml_to_file(yaml):
    gp_path = os.path.join(os.path.expanduser('~'), 'gp_data')
    f = open(gp_path, 'w+')
    f.write(yaml)
    f.close()


def grab_data(soup, class_name):
    '''Using BeautifulSoup's find_all function

    class_name is a string of the name of the class

    This function returns the text inside that tag.
    '''

    data = []

    for s in soup.find_all(class_=class_name):
        text = s.text
        text = text.strip()
        text = ', '.join([x.strip() for x in text.split('\r\n')])
        text = text.encode('ascii', 'ignore')

        if text.startswith("Tel: "):
            # strip off Tel: in front of the telephone number
            text = text[5:]

        data.append(text)

    return data


if __name__ == "__main__":
    gp_yaml = create_gp_yaml()
    write_yaml_to_file(gp_yaml)
