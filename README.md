# godot-echo3d-billiard-demo
Example Godot project with echo3D integration.

## Setup
* Built with Godot 4.4
* Register for FREE at [echo3D](https://console.echo3D.co/#/auth/register).
* Clone this repo. 

## Steps
* [Set the API key](https://docs.echo3d.co/quickstart/access-the-console) as the value for the constant API_KEY in the file config.gd. <br>
* [Type your Secret Key](https://docs.echo3d.co/web-console/deliver-pages/security-page#secret-key) as the value for the constant SEC_KEY in the file config.gd. _(Note: Secret Key only matters if you have the Security Key enabled). You can turn it off in the Security options in your echo3D console._<br>
* Type your echo3D account's email as the value for the constant EMAIL in the file config.gd.
* Type your authentication key as the value for the constant USER_KEY in the file config.gd. You can find this key by clicking the Dev Tools button.
* Upload assets in example_assets folder onto your echo3D console.
* Copy and paste the uploaded asset's ids as values for the constants BALL_ENTRY and TABLE_ENTRY.

## Run
Set "Simulator" as the main scene and in Godot, and run project. 

## Learn More
Refer to our [documentation](https://docs.echo3d.com/)to learn more about how to use echo3D.

## Troubleshooting
* Visit our troubleshooting guide [here](https://docs.echo3d.com/quickstart/troubleshooting).

## Support
Feel free to reach out at [support@echo3D.co](mailto:support@echo3D.co) or join our [support channel on Slack](https://go.echo3D.co/join). 
