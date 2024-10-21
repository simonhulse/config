function mvn-new
    if test (count $argv) -eq 1
        set artifactId $argv[1]
        set groupId com.shulse.app
    else if test (count $argv) -eq 2
        set artifactId $argv[1]
        set groupId $argv[2]
    else
        set artifactId my-app
        set groupId com.shulse.app
    end

    mvn archetype:generate -DgroupId=$groupId -DartifactId=$artifactId -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false
end
