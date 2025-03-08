import boto3

def lambda_handler(event, context):
    ec2_resource = boto3.resource('ec2')
    
    # Initialize counters before using them
    started_instances = 0
    running_instances = 0

    # Iterate through all instances
    for instance in ec2_resource.instances.all():
        instance_state = instance.state['Name']
        
        if instance_state == 'stopped':
            instance.start()
            started_instances += 1
        elif instance_state == 'running':
            running_instances += 1

    response_message = (
        f"Started {started_instances} instance(s). "
        f"{running_instances} instance(s) were already running."
    )

    return {"body": response_message}
